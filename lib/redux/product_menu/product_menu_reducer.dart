import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/redux/product_menu/product_menu_actions.dart';
import 'package:redux/redux.dart';

final productMenuReducer = combineReducers<List<Product>>([
  TypedReducer<List<Product>, OnAddedProductListAction>(_addedProductList),
]);

List<Product> _addedProductList(List<Product> productList, dynamic action){
  Product product = new Product.fromSnapshot(action.event.snapshot);
  bool duplicate = false;
  productList.forEach((entry){
       if(product.key == entry.key) duplicate = true;
  });
  if(!duplicate){
    productList
      ..add(new Product.fromSnapshot(action.event.snapshot))
      ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));
    productList.forEach((entry) => entry.number = 0);
  }

  return productList;
}