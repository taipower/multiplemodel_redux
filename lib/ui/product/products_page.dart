import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/ui/cart/cart_page.dart';
import 'package:multiplemodel_redux/widgets/product_grid.dart';
import 'package:multiplemodel_redux/redux/add_product/add_product_action.dart';

class ProductPageViewModel{
  final List<Product> entries;
  final List<Product> productMenu;
  final Function(Product) onItemChanged;

  ProductPageViewModel({
    this.entries,
    this.productMenu,
    this.onItemChanged,
  });
}

class ProductPage extends StatefulWidget{
  const ProductPage();

  @override
  State<ProductPage> createState(){
    return new ProductPageState();
  }
}

class ProductPageState extends State<ProductPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<AppState, ProductPageViewModel>(
        converter: (store) {
          return new ProductPageViewModel(
            entries: store.state.productEntry,
            productMenu: store.state.productList,
            onItemChanged: (entry) =>
                store.dispatch(new UpdateActiveProductAction(entry)),
          );
        },
        builder: (context, viewModel) {
          return Scaffold(
            body: ProductGrid(products: viewModel.productMenu,
              page: "ProductPage",
              viewModel: viewModel,
            ),
            floatingActionButton: new FloatingActionButton(
              onPressed: () => _openCartDialog(context, viewModel),
              child: new Icon(Icons.add_shopping_cart),
            ),
          );
        }
    );
  }

  _openCartDialog(BuildContext context, ProductPageViewModel viewModel) async{
    List<Product> cart = new List();
    viewModel.productMenu.forEach((entry){
      if(entry.number > 0){
        cart.add(entry);
      }
    });

    if(cart.length > 0){
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context){
            return new CartPage(cart);
          }
      ));
    }
  }
}