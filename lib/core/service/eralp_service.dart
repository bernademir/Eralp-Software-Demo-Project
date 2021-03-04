import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:todo/core/model/list_model.dart';
import 'package:todo/core/model/item_list.dart';
import 'package:todo/core/model/response_model.dart';
import 'package:todo/core/service/jwt_storage.dart';

class EralpApi {
  String requestUrl;
  var tokenValue;

  static EralpApi _instance = EralpApi._privateConstructor();
  EralpApi._privateConstructor() {
    requestUrl = "https://aodapi.eralpsoftware.net";
    tokenValue = JwtStorage().readToken();
  }

  static EralpApi getInstance() {
    if (_instance == null) {
      return EralpApi._privateConstructor();
    }
    return _instance;
  }

  Future<List<ResponseModel>> logIn(String username, String password) async {
    var res = await http.post(
      "$requestUrl/login/apply",
      body: {"username": username, "password": password},
    );
    final jsonResponse = json.decode(res.body);
    if (res.statusCode == 200) {
      final responseList = ResponseList.fromJsonList(jsonResponse);
      return responseList.responses;
    }
    return null;
  }

  Future<List<ListModel>> getItem() async {
    print("Authorization: $tokenValue");
    final response = await http.get(
      "$requestUrl/todo",
      headers: {"Authorization": "$tokenValue"},
    );

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final itemList = ItemList.fromJsonList(jsonResponse);
        return itemList.products;
        break;
      case HttpStatus.unauthorized:
        print("error getitem");
        break;
    }
    return Future.error(jsonResponse);
  }

  Future<void> addItem(ListModel product) async {
    final jsonBody = product.toJson();
    final response = await http.post(
      "$requestUrl/todo",
      body: jsonBody,
      headers: {
        "Content-type": "application/json",
        "Authorization": "$tokenValue"
      },
    );

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
        break;
      case HttpStatus.unauthorized:
        print("error additem");
        break;
    }
  }
}
