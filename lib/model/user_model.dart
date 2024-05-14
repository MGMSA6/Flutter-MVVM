class UserModel {
  String? token;
  String? userName;

  UserModel({this.token, this.userName});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['userName'] = userName;
    return data;
  }
}
