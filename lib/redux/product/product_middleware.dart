import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/redux/common_actions.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/product/product_actions.dart';
import 'package:redux/redux.dart';

class ProductMiddleware extends MiddlewareClass<AppState>{
  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async{
    print(action.runtimeType);
    if(action is InitAction){
      _handleInitAction(store);
    }else if(action is AddProductAction){
      _handleAddProductAction(store, action);
    }else if(action is UpdateProductAction){
      _handleUpdateProductAction(store, action);
    }else if(action is RemoveProductAction){
      _handleRemoveProductAction(store, action);
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
        .listen((event) => store.dispatch(new OnAddedProductAction(event)))
      ..onChildChanged
        .listen((event) => store.dispatch(new OnChangedProductAction(event)))
      ..onChildRemoved
        .listen((event) => store.dispatch(new OnRemovedProductAction(event)))
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

  _handleAddProductAction(Store<AppState> store, AddProductAction action){
    FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("product")
        .push()
        .set(action.product.toJson());
  }

  _handleUpdateProductAction(Store<AppState> store, UpdateProductAction action){
    print("action.product.key:"+action.product.key);
    FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("product")
        .child(action.product.key)
        .set(action.product.toJson());
  }

  _handleRemoveProductAction(Store<AppState> store, RemoveProductAction action){
    FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("product")
        .child(action.product.key)
        .remove();
  }
}