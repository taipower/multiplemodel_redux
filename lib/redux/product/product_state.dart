import 'package:firebase_database/firebase_database.dart';
import 'package:multiplemodel_redux/models/product.dart';
import 'package:meta/meta.dart';

@immutable
class ProductState{
  ProductState({
    @required this.mainReference,
    @required this.currentProduct,
    @required this.products,
    @required this.productList,
  });

  final DatabaseReference mainReference;
  final Product currentProduct;
  final List<Product> products;
  final List<Product> productList;

  factory ProductState.initial(){
    return ProductState(
      mainReference: null,
      currentProduct: null,
      products: <Product> [],
      productList: <Product> [],
    );
  }

  ProductState copyWith({
    DatabaseReference mainReference,
    Product currentProduct,
    List<Product> products,
    List<Product> productList,
  }){
    return ProductState(
      mainReference: mainReference ?? this.mainReference,
      currentProduct: currentProduct ?? this.currentProduct,
      products: products ?? this.products,
      productList: productList ?? this.productList,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
        other is ProductState &&
          runtimeType == other.runtimeType &&
          mainReference == other.mainReference &&
          currentProduct == other.currentProduct &&
          products == other.products &&
          productList == other.productList;

  @override
  int get hashCode =>
      mainReference.hashCode ^
      currentProduct.hashCode ^
      products.hashCode ^
      productList.hashCode;
}