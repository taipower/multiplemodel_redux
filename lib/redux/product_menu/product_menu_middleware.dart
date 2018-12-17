import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/redux/common_actions.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/product_menu/product_menu_actions.dart';
import 'package:redux/redux.dart';

class ProductMenuMiddleware extends MiddlewareClass<AppState>{
  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async{
    if(action is InitAction){
      _handleInitAction(store);
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
        .child("product")
      ..onChildAdded
          .listen((event) => store.dispatch(new OnAddedProductListAction(event)))
    )
    );
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
}