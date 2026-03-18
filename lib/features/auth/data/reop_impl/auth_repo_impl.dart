 import 'package:practice/core/base/result.dart';
import 'package:practice/features/auth/data/models/sign_up_model.dart';
import 'package:practice/features/auth/domain/repo/auth_repo.dart';

import '../source/auth_local.dart';

class AuthRepoImpl  implements AuthRepo {

  final AuthLocal _authLocal;
  AuthRepoImpl({required AuthLocal authLocal}) : _authLocal = authLocal;

  @override
  Future<Result<SignUpModel>> loginUser(
      String email,
      String password,
      ) async {
    try {
      final user = await _authLocal.loginUser(email,password);
      if (user == null) {
        return Result.failure(message: "No User Found");
      }
      print("userpassoer => ${user.password} and real password = $password");
      if (user.password!.trim() != password) {
        return Result.failure(message: "Invalid password");
      }
      return Result.success(data: user);
    } catch (e) {
      return Result.failure(message: e.toString());
    }
  }

  @override
  Future<Result<bool>> signUpUser(SignUpModel user) async {
    try {
     final result =  await _authLocal.signUpUser(user);
      if (result == false) {
        return Result.failure(message: "No User Registered");
      }
      return Result.success(data: true);
    } catch (e) {
      return Result.failure(message: e.toString());
    }
  }


 }