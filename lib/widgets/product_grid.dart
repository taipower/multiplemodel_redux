import 'package:flutter/material.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/widgets/product_grid_item.dart';
import 'package:meta/meta.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:multiplemodel_redux/utils/utils.dart';
import 'package:multiplemodel_redux/ui/product/product_page_view_model.dart';
import 'package:multiplemodel_redux/ui/product/products_page.dart';

class ProductGrid extends StatelessWidget{
  static const Key emptyViewKey = const Key('emptyview');
  static const Key contentKey = const Key('content');

  ProductGrid({
    @required this.products,
    @required this.page,
    this.viewModel
  });

  final List<Product> products;
  final String page;
  final ProductPageViewModel viewModel;

  _showOrderPicker(BuildContext context, ProductPageViewModel viewModel,
      Product orderItem){
    if(page == "ProductPage"){
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
  }

  Widget _buildContent(BuildContext context){
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var crossAxisChildCount = isPortrait ? 2 : 4;

    return Container(
      key: contentKey,
      color: const Color(0xFF222222),
      child: Scrollbar(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisChildCount,
              childAspectRatio: 2 / 3,
              ),
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index){
                var product = products[index];
                return ProductGridItem(
                  product: product,
                  onTapped: () => _showOrderPicker(context, viewModel, products[index]),
                );
              },
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildContent(context);
  }
}