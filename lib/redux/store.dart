import 'dart:async';

import 'package:multiplemodel_redux/redux/firebase/firebase_middleware.dart';
import 'package:multiplemodel_redux/redux/product/product_middleware.dart';
import 'package:multiplemodel_redux/redux/order/order_middleware.dart';
import 'package:multiplemodel_redux/redux/orderdetail/orderdetail_middleware.dart';
import 'package:multiplemodel_redux/redux/product_menu/product_menu_middleware.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:redux/redux.dart';
import 'package:multiplemodel_redux/redux/app/app_reducer.dart';

Future<Store<AppState>> createStore() async{
  return Store(
    appReducer,
    initialState: AppState.initial(),
    distinct: false,
    middleware: [
      FirebaseMiddleware(),
      ProductMenuMiddleware(),
      ProductMiddleware(),
      OrderMiddleware(),
      OrderDetailMiddleware(),
    ]
  );
}