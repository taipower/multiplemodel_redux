import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/ui/product/product_page_view_model.dart';
import 'package:multiplemodel_redux/widgets/product_list_item.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:multiplemodel_redux/utils/utils.dart';
import 'package:multiplemodel_redux/ui/cart/cart_page.dart';

class ProductsPage extends StatelessWidget{
  const ProductsPage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, ProductsPageViewModel>(
      distinct: false,
      converter: (store) => ProductsPageViewModel.fromStore(store),
      builder: (_, viewModel) => ProductsPageContent(viewModel),
    );
  }
}

class ProductsPageContent extends StatelessWidget{
  ProductsPageContent(this.viewModel);
  final ProductsPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new ListView.builder(
          shrinkWrap: true,
          itemCount: viewModel.productMenu.length,
          itemBuilder: (buildContext, index){
            return new InkWell(
              onTap: () => _showOrderPicker(context, viewModel, viewModel.productMenu[index]),
              child: new ProductListItem(viewModel.productMenu[index]),);
          }),
        floatingActionButton: new FloatingActionButton(
          onPressed: () => _openCartDialog(context, viewModel),
          child: new Icon(Icons.add_shopping_cart),
        ),
    );
  }

  _showOrderPicker(BuildContext context, ProductsPageViewModel viewModel,
      Product orderItem){
    showDialog<int>(
      context: context,
      builder: (context) =>
      new NumberPickerDialog.integer(
        minValue: 0,
        maxValue: 99,
        initialIntegerValue: 0,
        title: new Text("Enter your order"),
      ),
    ).then((int value){
      if(value != null){
        bool successful = false;

        successful = Utils.checkStock(value, orderItem.key, viewModel.entries);

        if(successful){
          viewModel.onItemChanged(orderItem..number = value);
        }else{
          Utils.showAlertDialog(context, "Alert Dialog",
              "Sorry our product less than your need!", "OK");
        }
      }
    });
  }

  _openCartDialog(BuildContext context, ProductsPageViewModel viewModel) async{
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