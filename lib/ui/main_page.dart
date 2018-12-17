import 'package:flutter/material.dart';
import 'package:multiplemodel_redux/ui/setting/setting_page.dart';
import 'package:multiplemodel_redux/ui/product/products_page.dart';
import 'package:multiplemodel_redux/ui/history/history_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainPage extends StatefulWidget{
  const MainPage();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
  with SingleTickerProviderStateMixin{
  TabController _controller;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

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
        title: Text('Yes Order App'),
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
          onPressed: () => _openSettingsPage(context)),
      new IconButton(icon: new Icon(Icons.exit_to_app),
          onPressed: () => _showDialog())
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sign Out"),
          content: new Text("You are sure sign out from Yes Order App?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              }
            ),
            new FlatButton(
              child: Text("Yes"),
              onPressed: () => _signOutWithGoogle(context)
            )
          ],
        );
      },
    );
  }

  Future<Null> _signOutWithGoogle(BuildContext context) async {
    // Sign out with firebase
    await auth.signOut();
    // Sign out with google
    await googleSignIn.signOut();

    Navigator.of(context).pop();
  }

}