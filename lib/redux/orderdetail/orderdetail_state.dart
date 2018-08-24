import 'package:multiplemodel_redux/models/orderdetail.dart';
import 'package:meta/meta.dart';

@immutable
class OrderDetailState{
  OrderDetailState({
    @required this.orderDetails,
  });

  final List<OrderDetail> orderDetails;

  factory OrderDetailState.initial(){
    return OrderDetailState(
      orderDetails: <OrderDetail>[],
    );
  }

  OrderDetailState copyWith({
    OrderDetail currentOrderDetail,
    List<OrderDetail> orderDetails,
  }){
    return OrderDetailState(
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
        other is OrderDetailState &&
          runtimeType == other.runtimeType &&
          orderDetails == other.orderDetails;

  @override
  int get hashCode =>
      orderDetails.hashCode;
}