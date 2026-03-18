 import 'package:practice/features/auth/domain/entities/user.dart';

class SignUpModel  {

  String? email;
  String? userId;
  String? password;
  String? userName;

  SignUpModel({required this.email,
    required this.password,
    required this.userId,
    required this.userName
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(email: json['email'],
        password: json['password'],
        userId: json['userId'],
        userName: json['userName']
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'userId': userId,
      'userName': userName,
    };
  }

 }