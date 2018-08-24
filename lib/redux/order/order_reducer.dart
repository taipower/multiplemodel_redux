import 'package:multiplemodel_redux/redux/order/order_actions.dart';
import 'package:multiplemodel_redux/models/order.dart';
import 'package:redux/redux.dart';

final orderReducer = combineReducers<List<Order>>([
  TypedReducer<List<Order>, OnAddedOrderAction>(_addedOrder),
]);

List<Order> _addedOrder(List<Order> orderEntry, dynamic action){
  orderEntry
    ..add(new Order.fromSnapshot(action.event.snapshot))
    ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));

  return orderEntry;
}