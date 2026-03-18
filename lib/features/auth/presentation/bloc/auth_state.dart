 import 'package:equatable/equatable.dart';

import '../../data/models/sign_up_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

 class SignUpInitial extends AuthState{

  @override
  List<Object> get props => [];
 }

 class SignUpLoading extends AuthState{

  @override
  List<Object> get props => [];
 }

 class SignUpSuccess extends AuthState{
   bool isSuccess;
   SignUpSuccess({required this.isSuccess});
   @override
  List<Object> get props => [isSuccess];
 }

 class SignUpFailure extends AuthState{
   String message;
   SignUpFailure({required this.message});
   @override
  List<Object> get props => [message];
 }

 class LoginInitial extends AuthState{

  @override
  List<Object> get props => [];
 }

 class LoginLoading extends AuthState{

  @override
  List<Object> get props => [];
 }


 class LoginSuccess extends AuthState{
  final SignUpModel user;
  const LoginSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

class LoginFailure extends AuthState{
  final String message;
  const LoginFailure({required this.message});
  @override
  List<Object> get props => [message];
}