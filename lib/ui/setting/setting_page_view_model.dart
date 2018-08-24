import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SettingPageViewModel{
  SettingPageViewModel({
    @required this.entries,
    @required this.openAddItemDialog
  });

  final List<Product> entries;
  final Function() openAddItemDialog;

  static SettingPageViewModel fromStore(Store<AppState> store){
    return SettingPageViewModel(
      entries: store.state.productEntry,
      openAddItemDialog: (){
        store.dispatch(new OpenAddProductDialogAction());
      }
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingPageViewModel &&
          runtimeType == other.runtimeType &&
          entries == other.entries;

  @override
  int get hashCode =>
      entries.hashCode;
}