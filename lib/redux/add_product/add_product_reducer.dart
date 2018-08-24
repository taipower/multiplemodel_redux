import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_action.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_state.dart';
import 'package:redux/redux.dart';

final addProductReducer = combineReducers<AddProductState>([
  TypedReducer<AddProductState, OpenAddProductDialogAction>(_openAddProductDialog),
  TypedReducer<AddProductState, UpdateActiveProductAction>(_updateActiveProduct),
]);

AddProductState _openAddProductDialog(AddProductState state, dynamic _){
  AddProductState newState = state;

  newState = newState.copyWith(
      activeProduct: new Product(new DateTime.now(), '', 0.0, 0)
  );

  return newState;
}

AddProductState _updateActiveProduct(AddProductState state, UpdateActiveProductAction action){
  AddProductState newState = state;
  
  newState = newState.copyWith(
    activeProduct: Product.copy(action.product)
  );

  return newState;
}