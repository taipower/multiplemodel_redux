import 'package:flutter/material.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/utils/utils.dart';
import 'package:multiplemodel_redux/ui/payment/payment_page.dart';
import 'package:multiplemodel_redux/widgets/product_grid.dart';

class CartPage extends StatefulWidget{
  CartPage(this.cart);
  final List<Product> cart;

  @override
  State<StatefulWidget> createState(){
    return new CartPageState(cart);
  }
}

class CartPageState extends State<CartPage>{
  CartPageState(this.cart);
  final List<Product> cart;
  double totalPrice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPrice = Utils.computeTotalPrice(cart);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Total Cart : " + totalPrice.toString() + " Bath"),
      ),
      body: ProductGrid(products: cart,
        page: "CartPage",
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () => _openPaymentPage(context),
          tooltip: 'Confirm Cart',
          child: new Text("OK")
      ),
    );
  }

  _openPaymentPage(BuildContext context) async{
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
        builder: (BuildContext context){
          return new PaymentDialog(cart);
        }
     ));
  }
}