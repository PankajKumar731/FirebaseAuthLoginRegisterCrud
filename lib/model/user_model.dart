class UserModel {
  String? username;
  String? mobileNumber;
  String? email;
  String? uid;

  UserModel({
    this.username,
    this.mobileNumber,
    this.email,
    this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "mobileNumber": mobileNumber,
        "email": email,
        "uid": uid,
      };
}
