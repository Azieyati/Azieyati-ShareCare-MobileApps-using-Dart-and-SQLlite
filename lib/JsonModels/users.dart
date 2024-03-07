class UsersModel {
  final int? userID;
  final String fullname;
  final String phonenumber;
  final String email;
  final String username;
  final String password;

  UsersModel({
    this.userID,
    required this.fullname,
    required this.phonenumber,
    required this.email,
    required this.username,
    required this.password,
  });

  factory UsersModel.fromMap(Map<String, dynamic> json) => UsersModel(
    userID: json["userID"],
    fullname: json["fullname"],
    phonenumber: json["phonenumber"],
    email: json["email"],
    username: json["username"],
    password: json["userpassword"],
  );

  Map<String, dynamic> toMap() => {
    "userID": userID,
    "fullname": fullname,
    "email": email,
    "phonenumber": phonenumber,
    "username": username,
    "userpassword": password,
  };
}