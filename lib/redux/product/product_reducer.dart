import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/redux/product/product_actions.dart';
import 'package:redux/redux.dart';

final productReducer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, OnAddedProductAction>(_addedProduct),
  TypedReducer<List<Product>, OnChangedProductAction>(_changedProduct),
  TypedReducer<List<Product>, OnRemovedProductAction>(_removedProduct),
]);

List<Product> _addedProduct(List<Product> entries, dynamic action){
  entries
    ..add(new Product.fromSnapshot(action.event.snapshot))
    ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));

  return entries;
}

List<Product> _changedProduct(List<Product> entries, dynamic action){
  Product newValue = new Product.fromSnapshot(action.event.snapshot);
  Product oldValue = entries.singleWhere((entry) => entry.key == newValue.key);
  entries
    ..[entries.indexOf(oldValue)] = newValue
    ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));

  return entries;
}

List<Product> _removedProduct(List<Product> entries, dynamic action){
  Product removeEntry = entries
      .singleWhere((entry) => entry.key == action.event.snapshot.key);
  entries
    ..remove(removeEntry)
    ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));

  return entries;
}


