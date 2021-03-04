import 'package:flutter/material.dart';
import 'package:todo/core/model/list_model.dart';
import 'package:todo/core/service/eralp_service.dart';
import 'package:todo/ui/shared/style/theme.dart';

import 'login_view.dart';

class AddView extends StatefulWidget {
  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();

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
      body: Form(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                todoTextWidget(),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) => myTheme.buttonColor)),
                  icon: Icon(Icons.send),
                  label: Text("Ekle"),
                  onPressed: () async {
                    var model = ListModel(
                        name: controllerName.text,
                        date: DateTime.now().toIso8601String());
                    await EralpApi.getInstance().addItem(model);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget todoTextWidget() {
    return TextFormField(
      controller: controllerName,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
          borderSide: BorderSide(
            color: myTheme.primaryColor,
            width: 1.0,
          ),
        ),
        fillColor: Colors.white54,
        filled: true,
        labelText: "ToDo",
      ),
    );
  }
}
