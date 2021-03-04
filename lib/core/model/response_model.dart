class ResponseModel {
  String status;
  String token;
  int userId;
  String message;

  ResponseModel({this.status, this.token, this.userId, this.message});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    userId = json['userId'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['message'] = this.message;
    return data;
  }
}

class ResponseList {
  List<ResponseModel> responses = [];
  ResponseList.fromJsonList(Map value) {
    value.forEach((token, value) {
      var res = ResponseModel.fromJson(value);
      res.token = token;
      responses.add(res);
    });
  }
}
