 import 'package:equatable/equatable.dart';

import '../../data/models/sign_up_model.dart';

abstract class AuthEvent extends Equatable {}

 class SignUpEvent extends AuthEvent {
   final SignUpModel user;

    SignUpEvent({required this.user});

  @override
  List<Object?> get props => [user];
 }


 class LoginEvent extends AuthEvent {
   final String email;
   final String password;

    LoginEvent({required this.email,required this.password});


  @override
  List<Object?> get props => [email,password];


}