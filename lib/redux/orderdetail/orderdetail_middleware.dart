import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/redux/common_actions.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/orderdetail/orderdetail_actions.dart';
import 'package:redux/redux.dart';

class OrderDetailMiddleware extends MiddlewareClass<AppState>{
  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async{
    print(action.runtimeType);
    if(action is InitAction){
      _handleInitAction(store);
    }else if(action is AddOrderDetailAction){
      _handleAddOrderDetailAction(store, action);
    }
    next(action);
    if(action is UserLoadedAction){
      _handleUserLoadedAction(store);
    }
  }

  _handleUserLoadedAction(Store<AppState> store){
    if(store.state.firebaseState.firebaseUser != null){
      store.dispatch(new AddDatabaseReferenceAction(FirebaseDatabase.instance
          .reference()
          .child(store.state.firebaseState.firebaseUser.uid)
          .child("orderDetail")
        ..onChildAdded
            .listen((event) => store.dispatch(new OnAddedOrderDetailAction(event)))
        )
      );
    }
  }

  _handleInitAction(Store<AppState> store){
    if(FirebaseAuth.instance != null){
      FirebaseAuth.instance.currentUser().then((user){
        if(user != null){
          store.dispatch(new UserLoadedAction(user));
        }
      });
    }
  }

  _handleAddOrderDetailAction(Store<AppState> store, AddOrderDetailAction action){
    if(store.state.firebaseState.firebaseUser != null){
      FirebaseDatabase.instance
          .reference()
          .child(store.state.firebaseState.firebaseUser.uid)
          .child("orderDetail")
          .push()
          .set(action.orderDetail.toJson());
    }
  }
}