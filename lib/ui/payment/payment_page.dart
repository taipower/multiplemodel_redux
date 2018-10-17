import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:multiplemodel_redux/models/order.dart';
import 'package:multiplemodel_redux/models/orderdetail.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/utils/utils.dart';
import 'package:multiplemodel_redux/ui/thank_you/thank_you_page.dart';
import 'package:multiplemodel_redux/redux/order/order_actions.dart';
import 'package:multiplemodel_redux/redux/orderdetail/orderdetail_actions.dart';
import 'package:multiplemodel_redux/redux/product/product_actions.dart';

class DialogViewModel{
  final Order orderList;
  final Function() onPaymentPress;

  DialogViewModel({
    this.orderList,
    this.onPaymentPress,
  });
}

class PaymentDialog extends StatefulWidget{
  final List<Product> cart;

  PaymentDialog(this.cart);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PaymentDialogState(cart);
  }
}

class PaymentDialogState extends State<PaymentDialog>{
  final List<Product> cart;
  List<Product> newListProduct;
  TextEditingController _textControllerName;
  TextEditingController _textControllerNumer;
  TextEditingController _textControllerExpire;
  TextEditingController _textControllerCVV;
  double totalPrice;
  String _bankName;
  String _cardNumber;
  String _date;
  String _cvv;
  bool _successful = false;
  DateTime dateTime;

  PaymentDialogState(this.cart);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textControllerName = new TextEditingController();
    _textControllerNumer = new TextEditingController();
    _textControllerExpire = new TextEditingController();
    _textControllerCVV = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<AppState, DialogViewModel>(
        converter: (store){
          int number = 0;
          int newNumber = 0;
          totalPrice = 0.0;
          dateTime = new DateTime.now();
          String orderKey = dateTime.millisecondsSinceEpoch.toString();

          List<OrderDetail> orderDetail = new List();
          newListProduct = new List();
          cart.forEach((entry){
            number += entry.number;
            totalPrice += entry.price * double.parse(entry.number.toString());
            OrderDetail orderDetailEntry = new OrderDetail(orderKey,
                new DateTime.now(), entry.name, entry.price, entry.number, entry.imgFile);
            orderDetail.add(orderDetailEntry);
          });
          Order activeItem = new Order(dateTime, totalPrice, number);
          return new DialogViewModel(
            orderList: activeItem,
            onPaymentPress: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => new Dialog(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Container(
                        padding: new EdgeInsets.all(8.0),
                        color: Colors.blue[100],
                        child: new Center(
                          child: new Column(
                            children: <Widget>[
                              new CircularProgressIndicator(),
                              new Text("Payment Processing..."),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
              new Future.delayed(new Duration(seconds: 2), (){
                Navigator.of(context).pop();
                _successful = Utils.validateCreditCard(_textControllerName.text,
                    _textControllerNumer.text, _textControllerExpire.text,
                    _textControllerCVV.text);

                if(!_successful){
                  Utils.showAlertDialog(context, "Alert Dialog",
                      "Please chek your credit card!", "OK");
                }else{
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => new ThankYouPage()));
                  store.dispatch(new AddOrderAction(activeItem));
                  orderDetail.forEach((entry) => store.dispatch
                    (new AddOrderDetailAction(entry)));
                  cart.forEach((entry){
                    store.state.productEntry.forEach((product){
                      if(entry.key == product.key){
                        newNumber = product.number - entry.number;
                        product.number = newNumber;
                        Product newProduct = new Product(product.dateTime, product.name,
                            product.price, product.number, product.imgFile);
                        newProduct.key = product.key;
                        newListProduct.add(newProduct);
                        return;
                      }
                    });
                  });
                  newListProduct.forEach((product) => store.dispatch
                    (new UpdateProductAction(product)));
                }
              });
            },
          );
        },
        builder: (context, viewModel){
          return new Scaffold(
              appBar: _createAppBar(context, viewModel),
              body: new Column(
                children: [
                  new Text("Total Price : " + totalPrice.toString()),
                  new ListTile(
                    leading: new Icon(Icons.account_balance, color: Colors.grey[500]),
                    title: new TextField(
                      decoration: new InputDecoration(
                          hintText: 'Cardholder Name'
                      ),
                      controller: _textControllerName,
                      onChanged: (value){
                        _bankName = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.credit_card, color: Colors.grey[500]),
                    title: new TextField(
                      decoration: new InputDecoration(
                          hintText: 'Card Number'
                      ),
                      controller: _textControllerNumer,
                      keyboardType: TextInputType.number,
                      maxLength: 19,
                      onChanged: (value){
                        _cardNumber = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.today, color: Colors.grey[500]),
                    title: new TextField(
                      decoration: new InputDecoration(
                          hintText: 'MM/YYYY'
                      ),
                      controller: _textControllerExpire,
                      keyboardType: TextInputType.datetime,
                      maxLength: 7,
                      onChanged: (value){
                        _date = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.dvr, color: Colors.grey[500]),
                    title: new TextField(
                      decoration: new InputDecoration(
                          hintText: 'CVV'
                      ),
                      controller: _textControllerCVV,
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      onChanged: (value){
                        _cvv = value;
                      },
                    ),
                  )
                ],
              )
          );
        });
  }

  Widget _createAppBar(BuildContext context, DialogViewModel viewModel){
    TextStyle actionStyle =
    Theme
        .of(context)
        .textTheme
        .subhead
        .copyWith(color: Colors.white);
    Text title = const Text("Payment");
    List<Widget> actions = [];
    actions.add(new FlatButton(
      onPressed: viewModel.onPaymentPress,
      child: new Text(
        'Confirm',
        style: actionStyle,
      ),
    ));

    return new AppBar(
      title: title,
      actions: actions,
    );
  }
}
