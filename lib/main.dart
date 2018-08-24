import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/common_actions.dart';
import 'package:multiplemodel_redux/redux/store.dart';
import 'package:redux/redux.dart';
import 'package:multiplemodel_redux/ui/main_page.dart';

Future<Null> main() async{
  // ignore: deprecated_member_use
  MaterialPageRoute.debugEnableFadingRoutes = true;

  var store = await createStore();
  runApp(YesOrderApp(store));
}

class YesOrderApp extends StatefulWidget{
  YesOrderApp(this.store);
  final Store<AppState> store;

  @override
  _YesOrderAppState createState() => _YesOrderAppState();
}

class _YesOrderAppState extends State<YesOrderApp>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.store.dispatch(InitAction());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreProvider<AppState>(
      store: widget.store,
      child: MaterialApp(
        title: 'Yes Order',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const MainPage(),
      ),
    );
  }
}
