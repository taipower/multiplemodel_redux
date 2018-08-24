import 'package:firebase_database/firebase_database.dart';
import 'package:quiver/core.dart';

class OrderDetail{
  String key;
  String keyOrder;
  DateTime dateTime;
  String name;
  double price;
  int number;

  OrderDetail(this.keyOrder, this.dateTime, this.name, this.price, this.number);

  OrderDetail.fromSnapshot(DataSnapshot snapshot)
    : key = snapshot.key,
      dateTime =
          new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
      keyOrder = snapshot.value["keyOrder"],
      name = snapshot.value["name"],
      price = snapshot.value["price"].toDouble(),
      number = snapshot.value["number"] as int;

  OrderDetail.copy(OrderDetail orderDetail)
    : key = orderDetail.key,
      dateTime = new DateTime.fromMillisecondsSinceEpoch(orderDetail.dateTime.millisecondsSinceEpoch),
      keyOrder = orderDetail.keyOrder,
      name = orderDetail.name,
      price = orderDetail.price,
      number = orderDetail.number;

  OrderDetail._internal(this.key, this.keyOrder, this.dateTime, this.name,
      this.price, this.number);

  OrderDetail copyWith(
    {String key, String keyOrder, DateTime dateTime, String name, double price, int number}){
    return new OrderDetail._internal(
        key ?? this.key,
        keyOrder ?? this.keyOrder,
        dateTime ?? this.dateTime,
        name ?? this.name,
        price ?? this.price,
        number ?? this.number
    );
  }

  toJson(){
    return {
      "keyOrder": keyOrder,
      "date": dateTime.millisecondsSinceEpoch,
      "name": name,
      "price": price,
      "number": number
    };
  }

  @override
  int get hashCode => hash4(key, dateTime, name, price);

  @override
  bool operator ==(other) =>
      other is OrderDetail &&
      key == other.key &&
      dateTime.millisecondsSinceEpoch == other.dateTime.millisecondsSinceEpoch &&
      keyOrder == other.keyOrder &&
      name == other.name &&
      price == other.price &&
      number == other.number;
}