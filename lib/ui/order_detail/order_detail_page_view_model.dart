import 'package:multiplemodel_redux/models/orderdetail.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class OrderDetailPageViewModel{
  OrderDetailPageViewModel({
    @required this.orderDetails,
  });

  final List<OrderDetail> orderDetails;

  static OrderDetailPageViewModel fromStore(Store<AppState> store){
    return OrderDetailPageViewModel(
      orderDetails: store.state.orderDetailEntry,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
        other is OrderDetailPageViewModel &&
            runtimeType == other.runtimeType &&
            orderDetails == other.orderDetails;

  @override
  int get hashCode =>
      orderDetails.hashCode;
}