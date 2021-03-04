import 'package:flutter/material.dart';
import 'package:todo/core/model/list_model.dart';
import 'package:todo/core/service/eralp_service.dart';
import 'package:todo/ui/shared/style/theme.dart';
import 'package:todo/ui/shared/widget/custom_card.dart';
import 'package:todo/ui/view/login_view.dart';
import 'dart:convert' show json, base64, ascii;

import 'add_view.dart';

class ToDoView extends StatefulWidget {
  final String jwt;
  final Map<String, dynamic> payload;
  ToDoView(this.jwt, this.payload);

  factory ToDoView.fromBase64(String jwt) => ToDoView(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  @override
  _ToDoViewState createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  List<ListModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myTheme.primaryColor,
        title: Text("Yapılacaklar"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginView()),
              );
            },
          )
        ],
      ),
      floatingActionButton: fabButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: FutureBuilder<List<ListModel>>(
        future: EralpApi.getInstance().getItem(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              list = snapshot.data;
              return _listView;
              break;
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  Widget get fabButton => FloatingActionButton(
        onPressed: fabPressed,
        child: Icon(Icons.add),
        shape: CircleBorder(
          side: BorderSide(color: Colors.white, width: 4.0),
        ),
        backgroundColor: myTheme.primaryColor,
      );

  void fabPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddView(),
      ),
    );
  }

  Widget get _listView => ListView.separated(
        itemBuilder: (context, index) => CustomCard(
          title: list[index].name,
          subtitle: "${list[index].date}",
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length,
      );
}
