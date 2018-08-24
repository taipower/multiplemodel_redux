import 'package:multiplemodel_redux/models/order.dart';
import 'package:meta/meta.dart';

@immutable
class OrderState{
  OrderState({
    @required this.currentOrder,
    @required this.orders,
  });

  final Order currentOrder;
  final List<Order> orders;

  factory OrderState.initial(){
    return OrderState(
      currentOrder: null,
      orders: <Order>[],
    );
  }

  OrderState copyWith({
    Order currentOrder,
    List<Order> orders,
  }){
    return OrderState(
      currentOrder: currentOrder ?? this.currentOrder,
      orders: orders ?? this.orders,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
        other is OrderState &&
          runtimeType == other.runtimeType &&
          currentOrder == other.currentOrder &&
          orders == other.orders;

  @override
  int get hashCode =>
      currentOrder.hashCode ^
      orders.hashCode;
}