import 'package:firebase_database/firebase_database.dart';
import 'package:quiver/core.dart';

class Product{
  String key;
  DateTime dateTime;
  String name;
  double price;
  int number;

  Product(this.dateTime, this.name, this.price, this.number);

  Product.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        dateTime =
        new DateTime.fromMicrosecondsSinceEpoch(snapshot.value["date"]),
        name = snapshot.value["name"],
        price = snapshot.value["price"].toDouble(),
        number = snapshot.value["number"] as int;

  Product.copy(Product product)
    : key = product.key,
      dateTime = new DateTime.fromMillisecondsSinceEpoch(product.dateTime.millisecondsSinceEpoch),
      name = product.name,
      price = product.price,
      number = product.number;

  Product._internal(this.key, this.dateTime, this.name, this.price, this.number);

  Product copyWith(
      {String key, DateTime dateTime, String name, double price, int number}){
    return new Product._internal(
        key ?? this.key,
        dateTime ?? this.dateTime,
        name ?? this.name,
        price ?? this.price,
        number ?? this.number
    );
  }

  toJson(){
    return {
      "name": name,
      "date": dateTime.millisecondsSinceEpoch,
      "price": price,
      "number": number
    };
  }

  @override
  int get hashCode => hash4(key, dateTime, name, price);

  @override
  bool operator ==(other) =>
      other is Product &&
          key == other.key &&
          dateTime.millisecondsSinceEpoch == other.dateTime
              .millisecondsSinceEpoch &&
          name == other.name &&
          price == other.price &&
          number == other.number;
}