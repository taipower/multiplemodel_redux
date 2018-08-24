import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/ui/history/history_page_view_model.dart';
import 'package:multiplemodel_redux/widgets/history_list_item.dart';
import 'package:multiplemodel_redux/ui/order_detail/order_detail_page.dart';

class HistoryPage extends StatelessWidget{
  const HistoryPage();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, HistoryPageViewModel>(
      distinct: false,
      converter: (store) => HistoryPageViewModel.fromStore(store),
      builder: (_, viewModel) => HistoryPageContent(viewModel),
    );
  }
}

class HistoryPageContent extends StatelessWidget{
  HistoryPageContent(this.viewModel);
  final HistoryPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        body: new ListView.builder(
        shrinkWrap: true,
        itemCount: viewModel.orders.length,
        itemBuilder: (buildContext, index){
          return new InkWell(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context){
                    return new OrderDetailPage(viewModel.orders[index].dateTime
                        .millisecondsSinceEpoch.toString());
                  }
              ));
            },
            child: new HistoryListItem(viewModel.orders[index]),);
          })
    );
  }
}