import 'package:multiplemodel_redux/models/order.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class HistoryPageViewModel{
  HistoryPageViewModel({
    @required this.orders,
  });

  final List<Order> orders;

  static HistoryPageViewModel fromStore(Store<AppState> store){
    return HistoryPageViewModel(
      orders: store.state.orderEntry,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryPageViewModel &&
          runtimeType == other.runtimeType &&
          orders == other.orders;

  @override
  int get hashCode =>
      orders.hashCode;
}