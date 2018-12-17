import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:multiplemodel_redux/redux/app/app_state.dart';
import 'package:multiplemodel_redux/redux/common_actions.dart';
import 'package:multiplemodel_redux/redux/store.dart';
import 'package:redux/redux.dart';
import 'package:multiplemodel_redux/ui/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiplemodel_redux/ui/splash_page.dart';
import 'package:multiplemodel_redux/ui/login_page.dart';

Future<Null> main() async{
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
//    widget.store.dispatch(InitAction());
  }

  Widget _handleCurrentPage(){
    return new StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return new SplashPage();
          }else{
            if(snapshot.hasData){
              widget.store.dispatch(InitAction());
              return StoreProvider<AppState>(
                store: widget.store,
                child: MaterialApp(
                  title: 'Yes Order App',
                  theme: ThemeData(
                    primarySwatch: Colors.green,
                  ),
                  home: new MainPage(),
                ),
              );
            }
            return new LoginPage();
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Yes Order App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: _handleCurrentPage(),
    );
  }
}
