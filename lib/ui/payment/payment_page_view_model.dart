import 'package:multiplemodel_redux/models/order.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/order/order_actions.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class PaymentPageViewModel{
  PaymentPageViewModel({
    @required this.orderEntries,
    @required this.onPaymentPress,
  });

  final Order orderEntries;
  final Function() onPaymentPress;

  static PaymentPageViewModel fromStore
      (Store<AppState> store, double totalPrice, int number){
    Order orderActive = new Order(new DateTime.now(), totalPrice, number);
    return PaymentPageViewModel(
      orderEntries: orderActive,
      onPaymentPress: () => store.dispatch(new AddOrderAction(orderActive)),
    );
  }

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is PaymentPageViewModel &&
      runtimeType == other.runtimeType &&
      orderEntries == other.orderEntries;

  @override
  int get hashCode =>
      orderEntries.hashCode;
}