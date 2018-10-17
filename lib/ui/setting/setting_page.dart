import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/ui/setting/setting_page_view_model.dart';
import 'package:multiplemodel_redux/widgets/product_list_item.dart';
import 'package:multiplemodel_redux/ui/add_product/add_product_page.dart';
import 'package:multiplemodel_redux/widgets/product_grid.dart';

class SettingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, SettingPageViewModel>(
      distinct: false,
      converter: (store) => SettingPageViewModel.fromStore(store),
      builder: (_, viewModel) => SettingPageContent(viewModel),
    );
  }
}

class SettingPageContent extends StatelessWidget{
  SettingPageContent(this.viewModel);
  final SettingPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Setting'),
      ),
//      body: new ListView.builder(
//          shrinkWrap: true,
//          itemCount: viewModel.entries.length,
//          itemBuilder: (BuildContext context, index){
//            return new InkWell(
//              onTap: null,
//              child: new ProductListItem(viewModel.entries[index]));
//          },
//      ),
      body: ProductGrid(products: viewModel.entries,
        page: "SettingPage",
      ),
      floatingActionButton: new FloatingActionButton(
          onPressed: () => _onAddProduct(context, viewModel),
          tooltip: 'Add Product',
          child: new Icon(Icons.add),
      ),
    );
  }

  _onAddProduct(BuildContext context, SettingPageViewModel viewModel){
    viewModel.openAddItemDialog();
    Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context){
            return new AddProductPage();
          }
    ));
  }
}