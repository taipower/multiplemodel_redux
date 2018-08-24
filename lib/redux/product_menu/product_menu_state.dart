import 'package:multiplemodel_redux/models/product.dart';
import 'package:meta/meta.dart';

@immutable
class ProductMenuState{
  ProductMenuState({
    @required this.productList,
  });

  final List<Product> productList;

  factory ProductMenuState.initial(){
    return ProductMenuState(
      productList: <Product> [],
    );
  }

  ProductMenuState copyWith({
    List<Product> productList,
  }){
    return ProductMenuState(
      productList: productList ?? this.productList,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
        other is ProductMenuState &&
            productList == other.productList;

  @override
  int get hashCode =>
      productList.hashCode;
}