import 'package:multiplemodel_redux/models/product.dart';
import 'package:meta/meta.dart';

@immutable
class AddProductState{
  AddProductState({
    @required this.activeProduct,
  });

  final Product activeProduct;

  factory AddProductState.initial(){
    return AddProductState(
      activeProduct: null,
    );
  }

  AddProductState copyWith({
    Product activeProduct,
  }){
    return AddProductState(
      activeProduct: activeProduct ?? this.activeProduct
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AddProductState &&
        runtimeType == other.runtimeType &&
        activeProduct == other.activeProduct;

  @override
  int get hashCode =>
      activeProduct.hashCode;
}