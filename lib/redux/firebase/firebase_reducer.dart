import 'package:multiplemodel_redux/redux/firebase/firebase_state.dart';
import 'package:multiplemodel_redux/redux/firebase/firebase_actions.dart';
import 'package:redux/redux.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/redux/common_actions.dart';

final firebaseReducer = combineReducers<FirebaseState>([
  TypedReducer<FirebaseState, initFirebase>(_init),
]);

FirebaseState _init(FirebaseState state, dynamic action){
  FirebaseState newState;
  if(action is InitAction){
    FirebaseDatabase.instance.setPersistenceEnabled(true);
  }else if(action is UserLoadedAction){
    newState = newState.copyWith(firebaseUser: action.firebaseUser);
  }else if(action is AddDatabaseReferenceAction){
    newState = newState.copyWith(mainReference: action.databaseReference);
  }

  return newState;
}