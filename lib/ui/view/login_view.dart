import 'package:flutter/material.dart';
import 'package:todo/core/model/response_model.dart';
import 'package:todo/core/service/eralp_service.dart';
import 'package:todo/core/service/jwt_storage.dart';
import 'package:todo/ui/shared/style/theme.dart';
import 'package:todo/ui/shared/widget/custom_clipper_widget.dart';
import 'package:todo/ui/view/bottom_navbar_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  JwtStorage strg = JwtStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Column(
          children: [
            clipPath(),
            SizedBox(height: 80),
            usernameTextField(),
            passwordTextField(),
            textButtonGiris(),
          ],
        ),
      ),
    );
  }

  Widget usernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white54,
        filled: true,
        hintText: "Kullanıcı Adı",
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
          borderSide: BorderSide(
            color: myTheme.primaryColor,
            width: 1.0,
          ),
        ),
      ),
      controller: controllerName,
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white54,
        filled: true,
        hintText: "Şifre",
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
          borderSide: BorderSide(
            color: myTheme.primaryColor,
            width: 1.0,
          ),
        ),
      ),
      controller: controllerPassword,
      obscureText: true,
    );
  }

  Widget textButtonGiris() {
    List<ResponseModel> jwt = [];
    return TextButton(
      onPressed: () async {
        var username = controllerName.text;
        var password = controllerPassword.text;
        jwt = await EralpApi.getInstance().logIn(username, password);
        if (jwt != null) {
          print(jwt);
          strg.writeToken(jwt[1]);
          print("token yazildi");
          print(strg.readToken());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BottomNavBarView.fromBase64(jwt.toString())));
        } else {
          displayDialog(context, "Hatalı Giriş",
              "Lütfen kullanıcı adı ve şifrenizi kontrol edip tekrar giriş yapınız.");
        }
      },
      child: Text(
        "Giriş",
        style: myTheme.textTheme.headline2,
      ),
      style: TextButton.styleFrom(
        backgroundColor: myTheme.buttonColor,
      ),
    );
  }

  Widget clipPath() {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          child: ClipPath(
            clipper: CustomClipperWidget(),
            child: Container(
              color: myTheme.primaryColor,
              width: double.infinity,
              height: 250.0,
            ),
          ),
        ),
        Positioned(
          top: 150,
          left: (MediaQuery.of(context).size.width / 2) - 60,
          height: 120,
          width: 120,
          child: SizedBox(
            child: Image.asset(
              "C:/Users/berna/Desktop/projects/flutter projects/eralpSoftware/todo/lib/assets/images/logo.png",
              width: 120.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  void displayDialog(context, title, text) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title, style: TextStyle(color: myTheme.focusColor)),
          content: Text(text),
        ),
      );
}
