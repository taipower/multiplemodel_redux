import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/ui/add_product/add_product_page_view_model.dart';

class AddProductPage extends StatelessWidget{
  AddProductPage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, AddProductPageViewModel>(
      distinct: false,
      converter: (store) => AddProductPageViewModel.fromStore(store),
      builder: (_, viewModel) => AddProductPageContent(viewModel),
    );
  }
}

class AddProductPageContent extends StatelessWidget{
  AddProductPageContent(this.viewModel);
  final AddProductPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _createAppBar(context, viewModel),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.title, color: Colors.grey[500]),
            title: TextField(
              decoration: InputDecoration(
                hintText: 'Product Name'
              ),
              onChanged: (value){
                viewModel.onItemChanged(viewModel.entry..name = value);
              },
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.attach_money, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Price',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value){
                viewModel.onItemChanged
                  (viewModel.entry..price = double.parse(value));
              },
            ),
          ),
          new ListTile(
            leading: new Icon(Icons.content_paste, color: Colors.grey[500]),
            title: new TextField(
              decoration: new InputDecoration(
                hintText: 'Number'
              ),
              keyboardType: TextInputType.number,
              onChanged: (value){
                viewModel.onItemChanged
                  (viewModel.entry..number = int.parse(value));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAppBar(BuildContext context, AddProductPageViewModel viewModel){
    TextStyle actionStyle =
        Theme.of(context).textTheme.subhead.copyWith(color: Colors.white);
    Text title = const Text("New Product");
    List<Widget> actions = [];
    actions.add(new FlatButton(
        onPressed: (){
          viewModel.onSavePressed();
          Navigator.of(context).pop();
        },
        child: Text(
          'SAVE',
          style: actionStyle,
        ),
    ));

    return new AppBar(
      title: title,
      actions: actions,
    );
  }
}
