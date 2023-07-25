class LoginModel {
  String? login;
  String? password;
  String? token;

  LoginModel({this.login, this.password,this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    password = json['password'];
    token = json['token'] == null ? 'gr4731': json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['password'] = this.password;
    data['token'] = this.token;
    return data;
  }
}
