import 'package:multiplemodel_redux/redux/order/order_state.dart';
import 'package:multiplemodel_redux/redux/orderdetail/orderdetail_state.dart';
import 'package:multiplemodel_redux/redux/product/product_state.dart';
import 'package:multiplemodel_redux/redux/product_menu/product_menu_state.dart';
import 'package:multiplemodel_redux/redux/firebase/firebase_state.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_state.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/models/order.dart';
import 'package:multiplemodel_redux/models/orderdetail.dart';
import 'package:meta/meta.dart';

@immutable
class AppState{
  AppState({
    @required this.firebaseState,
    @required this.productEntry,
    @required this.productList,
    @required this.orderEntry,
    @required this.orderDetailEntry,
    @required this.addProductState,
  });

  final FirebaseState firebaseState;
  final List<Product> productEntry;
  final List<Product> productList;
  final List<Order> orderEntry;
  final List<OrderDetail> orderDetailEntry;
  final AddProductState addProductState;

  factory AppState.initial(){
    return AppState(
      firebaseState: FirebaseState.initial(),
      productEntry: ProductState.initial().products,
      productList: ProductMenuState.initial().productList,
      orderEntry: OrderState.initial().orders,
      orderDetailEntry: OrderDetailState.initial().orderDetails,
      addProductState: AddProductState.initial(),
    );
  }

  AppState copyWith({
    FirebaseState firebaseState,
    ProductState products,
    ProductMenuState productList,
    OrderState orders,
    OrderDetailState orderDetails,
    AddProductState addProductState,
  }){
    return AppState(
      firebaseState: firebaseState ?? this.firebaseState,
      productEntry: products ?? this.productEntry,
      productList: productList ?? this.productList,
      orderEntry: orders ?? this.orderEntry,
      orderDetailEntry: orderDetails ?? this.orderDetailEntry,
      addProductState: addProductState ?? this.addProductState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
            runtimeType == other.runtimeType &&
            firebaseState == other.firebaseState &&
            productEntry == other.productEntry &&
            productList == other.productList &&
            orderEntry == other.orderEntry &&
            orderDetailEntry == other.orderDetailEntry &&
            addProductState == other.addProductState;

  @override
  int get hashCode =>
      firebaseState.hashCode ^
      productEntry.hashCode ^
      productList.hashCode ^
      orderEntry.hashCode ^
      orderDetailEntry.hashCode ^
      addProductState.hashCode;
}