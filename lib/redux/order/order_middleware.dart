import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/redux/common_actions.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/order/order_actions.dart';
import 'package:redux/redux.dart';

class OrderMiddleware extends MiddlewareClass<AppState>{
  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async{
    print(action.runtimeType);
    if(action is InitAction){
      _handleInitAction(store);
    }else if(action is AddOrderAction){
      _handleAddOrderAction(store, action);
    }
    next(action);
    if(action is UserLoadedAction){
      _handleUserLoadedAction(store);
    }
  }

  _handleUserLoadedAction(Store<AppState> store){
    store.dispatch(new AddDatabaseReferenceAction(FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("order")
      ..onChildAdded
          .listen((event) => store.dispatch(new OnAddedOrderAction(event)))
    )
    );
  }

  _handleInitAction(Store<AppState> store){
    if(store.state.firebaseState.firebaseUser == null){
      FirebaseAuth.instance.currentUser().then((user){
        if(user != null){
          store.dispatch(new UserLoadedAction(user));
        }else{
          FirebaseAuth.instance
              .signInAnonymously()
              .then((user) => store.dispatch(new UserLoadedAction(user)));
        }
      });
    }
  }

  _handleAddOrderAction(Store<AppState> store, AddOrderAction action){
    FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("order")
        .push()
        .set(action.order.toJson());
  }
}