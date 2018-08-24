import 'package:multiplemodel_redux/models/order.dart';

class InitAction{}

class InitCompleteAction{
  InitCompleteAction(
      this.orders,
      this.selectedOrder,
  );

  final List<Order> orders;
  final Order selectedOrder;
}

class ChangeCurrentOrderAction{
  ChangeCurrentOrderAction(this.selectedOrder);
  final Order selectedOrder;
}
