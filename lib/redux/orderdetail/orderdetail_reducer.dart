import 'package:multiplemodel_redux/redux/orderdetail/orderdetail_actions.dart';
import 'package:multiplemodel_redux/models/orderdetail.dart';
import 'package:redux/redux.dart';

final orderDetailReducer = combineReducers<List<OrderDetail>>([
  TypedReducer<List<OrderDetail>, OnAddedOrderDetailAction>(_addedOrderDetail),
]);

List<OrderDetail> _addedOrderDetail(List<OrderDetail> orderDetailEntry, dynamic action){
  orderDetailEntry
    ..add(new OrderDetail.fromSnapshot(action.event.snapshot))
    ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));

  return orderDetailEntry;
}