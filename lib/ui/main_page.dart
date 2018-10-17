import 'package:flutter/material.dart';
import 'package:multiplemodel_redux/ui/setting/setting_page.dart';
import 'package:multiplemodel_redux/ui/product/products_page.dart';
import 'package:multiplemodel_redux/ui/history/history_page.dart';

class MainPage extends StatefulWidget{
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
  with SingleTickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Yes Order'),
        actions: _buildMenuActions(context),
        bottom: TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: const <Tab>[
              const Tab(text: 'Product'),
              const Tab(text: 'History'),
            ],
        ),
      ),
      body: TabBarView(
          controller: _controller,
          children: <Widget>[
            const ProductPage(),
            const HistoryPage(),
          ],
      ),
    );
  }

  List<Widget> _buildMenuActions(BuildContext context){
    List<Widget> actions = [
      new IconButton(icon: new Icon(Icons.settings),
          onPressed: () => _openSettingsPage(context))
    ];

    return actions;
  }

  _openSettingsPage(BuildContext context){
    Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context){
            return new SettingPage();
          }
    ));
  }
}