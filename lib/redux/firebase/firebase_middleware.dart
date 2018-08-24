import 'dart:async';

import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/common_actions.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMiddleware extends MiddlewareClass<AppState>{
  @override
  Future<Null> call(
      Store<AppState> store, dynamic action, NextDispatcher next) async{
    if(action is InitAction){
      _handleInitAction(store);
    }
    next(action);
  }

  _handleInitAction(Store<AppState> store){
    if(store.state.firebaseState.firebaseUser == null){
      FirebaseAuth.instance.currentUser().then((user){
        if(user != null){
          store.state.firebaseState.firebaseUser = user;
        }else{
          FirebaseAuth.instance
              .signInAnonymously()
              .then((user) => store.state.firebaseState.firebaseUser = user);
        }
      });
    }
  }
}