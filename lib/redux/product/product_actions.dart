import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/models/product.dart';

class UserLoadedAction{
  final FirebaseUser firebaseUser;

  UserLoadedAction(this.firebaseUser);
}

class AddDatabaseReferenceAction{
  final DatabaseReference databaseReference;

  AddDatabaseReferenceAction(this.databaseReference);
}

class OnAddedProductAction{
  final Event event;

  OnAddedProductAction(this.event);
}

class OnRemovedProductAction{
  final Event event;

  OnRemovedProductAction(this.event);
}

class OnChangedProductAction{
  final Event event;

  OnChangedProductAction(this.event);
}

class RefreshProductsAction {}

class FetchProductAction{
  final List<Product> entries;

  FetchProductAction(this.entries);
}

class AddProductAction{
  final Product product;

  AddProductAction(this.product);
}

class RemoveProductAction{
  final Product product;

  RemoveProductAction(this.product);
}

class UpdateProductAction{
  final Product product;

  UpdateProductAction(this.product);
}