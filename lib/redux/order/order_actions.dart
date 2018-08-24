import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/models/order.dart';

class UserLoadedAction{
  final FirebaseUser firebaseUser;

  UserLoadedAction(this.firebaseUser);
}

class AddDatabaseReferenceAction{
  final DatabaseReference databaseReference;

  AddDatabaseReferenceAction(this.databaseReference);
}

class OnAddedOrderAction{
  final Event event;

  OnAddedOrderAction(this.event);
}

class AddOrderAction{
  final Order order;

  AddOrderAction(this.order);
}