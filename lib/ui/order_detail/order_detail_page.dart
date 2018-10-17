import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/ui/order_detail/order_detail_page_view_model.dart';
import 'package:multiplemodel_redux/models/orderdetail.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/widgets/product_grid.dart';

class OrderDetailPage extends StatelessWidget{
  OrderDetailPage(this.orderKey);
  final String orderKey;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, OrderDetailPageViewModel>(
      distinct: false,
      converter: (store) => OrderDetailPageViewModel.fromStore(store),
      builder: (_, viewModel) => OrderDetailPageContent(viewModel, orderKey),
    );
  }
}

class OrderDetailPageContent extends StatelessWidget{
  OrderDetailPageContent(this.viewModel, this.orderKey);
  final OrderDetailPageViewModel viewModel;
  final String orderKey;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<OrderDetail> listTemp = viewModel.orderDetails;
    List<Product> listProduct = new List();
    listTemp.forEach((entry){
      if(entry.keyOrder == orderKey){
        Product product = new Product(
            new DateTime.fromMicrosecondsSinceEpoch(int.parse(entry.keyOrder)),
            entry.name, entry.price, entry.number, entry.imgFile);
        listProduct.add(product);
      }
    });
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Order Detail"),
        ),
      body: ProductGrid(products: listProduct,
        page: "OrderDetail",
      ),
    );
  }
}
