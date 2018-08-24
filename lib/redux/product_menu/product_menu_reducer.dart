import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/redux/product_menu/product_menu_actions.dart';
import 'package:redux/redux.dart';

final productMenuRedicer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, OnAddedProductListAction>(_addedProductList),
]);

List<Product> _addedProductList(List<Product> productList, dynamic action){
  productList
    ..add(new Product.fromSnapshot(action.event.snapshot))
    ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));
  productList.forEach((entry) => entry.number = 0);

  return productList;
}