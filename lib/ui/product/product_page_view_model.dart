import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_action.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class ProductsPageViewModel{
  ProductsPageViewModel({
    @required this.entries,
    @required this.productMenu,
    @required this.onItemChanged,
  });

  final List<Product> entries;
  final List<Product> productMenu;
  final Function(Product) onItemChanged;

  static ProductsPageViewModel fromStore(Store<AppState> store){
    return ProductsPageViewModel(
      entries: store.state.productEntry,
      productMenu: store.state.productList,
      onItemChanged: (entry) => store.dispatch(new UpdateActiveProductAction(entry)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsPageViewModel &&
        runtimeType == other.runtimeType &&
        entries == other.entries &&
        productMenu == other.productMenu;

  @override
  int get hashCode =>
      entries.hashCode ^
      productMenu.hashCode;

}