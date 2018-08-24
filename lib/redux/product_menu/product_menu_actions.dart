import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserLoadedAction{
  final FirebaseUser firebaseUser;

  UserLoadedAction(this.firebaseUser);
}

class AddDatabaseReferenceAction{
  final DatabaseReference databaseReference;

  AddDatabaseReferenceAction(this.databaseReference);
}

class OnAddedProductListAction{
  final Event event;

  OnAddedProductListAction(this.event);
}