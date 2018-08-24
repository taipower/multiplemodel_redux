import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/models/orderdetail.dart';

class UserLoadedAction{
  final FirebaseUser firebaseUser;

  UserLoadedAction(this.firebaseUser);
}

class AddDatabaseReferenceAction{
  final DatabaseReference databaseReference;

  AddDatabaseReferenceAction(this.databaseReference);
}

class OnAddedOrderDetailAction{
  final Event event;

  OnAddedOrderDetailAction(this.event);
}

class AddOrderDetailAction{
  final OrderDetail orderDetail;

  AddOrderDetailAction(this.orderDetail);
}

