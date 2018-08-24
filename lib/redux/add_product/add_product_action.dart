import 'package:multiplemodel_redux/models/product.dart';

class OpenAddProductDialogAction{

}

class UpdateActiveProductAction{
  final Product product;

  UpdateActiveProductAction(this.product);
}