import 'package:flutter/material.dart';
import 'package:multiplemodel_redux/models/order.dart';

class HistoryListItem extends StatelessWidget{
  HistoryListItem(this.orders);
  final Order orders;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget titleScreen = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    orders.totalPrice.toString() + " Bath",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  orders.dateTime.year.toString() + "-"
                      + orders.dateTime.month.toString() + "-"
                      + orders.dateTime.day.toString() + " "
                      + orders.dateTime.hour.toString() + ":"
                      + orders.dateTime.minute.toString() + ":"
                      + orders.dateTime.second.toString(),
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Text(
            orders.number.toString(),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0
            ),
          ),
        ],
      ),
    );

    return titleScreen;
  }
}