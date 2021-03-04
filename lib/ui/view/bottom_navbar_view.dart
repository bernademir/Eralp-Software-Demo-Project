import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/shared/style/theme.dart';
import 'package:todo/ui/view/profile_view.dart';
import 'package:todo/ui/view/todo_view.dart';
import 'dart:convert' show json, base64, ascii;


class BottomNavBarView extends StatefulWidget {
   final String jwt;
   final Map<String, dynamic> payload;
   BottomNavBarView(this.jwt, this.payload);

   factory BottomNavBarView.fromBase64(String jwt) => BottomNavBarView(
       jwt,
       json.decode(
           ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  @override
  _BottomNavBarViewState createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  String jwt;
  Map<String, dynamic> payload;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Anasayfa", myTheme.focusColor),
    new TabItem(Icons.account_circle, "Profil", myTheme.focusColor),
  ]);

  int selectedPosition = 0;
  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController =
        new CircularBottomNavigationController(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          bodyContainer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomNavBar(),
          )
        ],
      ),
    );
  }

  Widget bodyContainer() {
    if (selectedPosition == 0) {
      return ToDoView(jwt, payload);
    } else if (selectedPosition == 1) {
      return ProfileView();
    }
    return Container();
  }

  Widget bottomNavBar() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: 60,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          selectedPosition = selectedPos;
        });
      },
    );
  }
}
