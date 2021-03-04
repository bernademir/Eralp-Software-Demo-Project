import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo/core/model/response_model.dart';

class JwtStorage {
  static const String SECURE_NOTE_KEY = "KEY";
  FlutterSecureStorage storage = FlutterSecureStorage();
  String value;

  Future writeToken(ResponseModel resToken) async {
    await storage.write(key: SECURE_NOTE_KEY, value: resToken.token.toString());
    value = "";
  }

  Future readToken() async {
    value = await storage.read(key: SECURE_NOTE_KEY);

    print("Decrypted edilen Token: \n$value");
  }
}
