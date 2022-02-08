class LoginModel{

  bool status;
  String message;
  UserData data;

   LoginModel.fromJson(Map<String , dynamic> json){
    this.status = json['status'];
    this.message = json['message'];
    this.data = json['data'] != null? UserData.fromJson(json['data']): null;
  }
}


class UserData{
  int id;
  String name;
  String email;
  String phone;
  String image;
  String token;
  int points;
  int credit;

  UserData.fromJson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
    points = json['points'];
    credit = json['credit'];
    image = json['image'];
  }
}