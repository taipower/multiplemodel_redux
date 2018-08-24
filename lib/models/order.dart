import 'package:firebase_database/firebase_database.dart';
import 'package:quiver/core.dart';

class Order{
  String key;
  DateTime dateTime;
  double totalPrice;
  int number;

  Order(this.dateTime, this.totalPrice, this.number);

  Order.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        dateTime =
        new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        totalPrice = snapshot.value["totalPrice"].toDouble(),
        number = snapshot.value["number"] as int;

  Order.copy(Order order)
    : key = order.key,
        dateTime = new DateTime.fromMillisecondsSinceEpoch(order.dateTime.millisecondsSinceEpoch),
        totalPrice = order.totalPrice,
        number = order.number;

  Order._internal(this.key, this.dateTime, this.totalPrice, this.number);

  Order copyWith(
      {String key, DateTime dateTime, double totalPrice, int number}){
    return new Order._internal(
        key ?? this.key,
        dateTime ?? this.dateTime,
        totalPrice ?? this.totalPrice,
        number ?? this.number
    );
  }

  toJson(){
    return {
      "date": dateTime.millisecondsSinceEpoch,
      "totalPrice": totalPrice,
      "number": number
    };
  }

  @override
  int get hashCode => hash4(key, dateTime, totalPrice, number);

  @override
  bool operator ==(other) =>
      other is Order &&
          key == other.key &&
          dateTime.millisecondsSinceEpoch == other.dateTime
              .millisecondsSinceEpoch &&
          totalPrice == other.totalPrice &&
          number == other.number;
}