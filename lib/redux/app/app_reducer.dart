import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/firebase/firebase_reducer.dart';
import 'package:multiplemodel_redux/redux/product/product_reducer.dart';
import 'package:multiplemodel_redux/redux/product_menu/product_menu_reducer.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_reducer.dart';
import 'package:multiplemodel_redux/redux/order/order_reducer.dart';
import 'package:multiplemodel_redux/redux/orderdetail/orderdetail_reducer.dart';

AppState appReducer(AppState state, dynamic action){
  return new AppState(
      firebaseState: firebaseReducer(state.firebaseState, action),
      productEntry: productReducer(state.productEntry, action),
      productList: productMenuRedicer(state.productList, action),
      orderEntry: orderReducer(state.orderEntry, action),
      orderDetailEntry: orderDetailReducer(state.orderDetailEntry, action),
      addProductState: addProductReducer(state.addProductState, action),
  );
}