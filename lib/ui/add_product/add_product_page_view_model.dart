import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/product/product_actions.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class AddProductPageViewModel{
  AddProductPageViewModel({
    @required this.entry,
    @required this.onItemChanged,
    @required this.onSavePressed,
  });

  final Product entry;
  final Function(Product) onItemChanged;
  final Function onSavePressed;

  static AddProductPageViewModel fromStore(Store<AppState> store){
    Product activeProduct = store.state.addProductState.activeProduct;
    return AddProductPageViewModel(
      entry: activeProduct,
      onItemChanged: (entry) => store.dispatch(new UpdateActiveProductAction(entry)),
      onSavePressed: () => store.dispatch(new AddProductAction(activeProduct)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddProductPageViewModel &&
      runtimeType == other.runtimeType &&
      entry == other.entry;

  @override
  int get hashCode =>
      entry.hashCode;
}