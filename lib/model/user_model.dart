class UserModel {
  late String token;

  UserModel({required this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}
