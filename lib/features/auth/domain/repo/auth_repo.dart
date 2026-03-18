 import '../../../../core/base/result.dart';
import '../../data/models/sign_up_model.dart';

abstract interface class  AuthRepo{
   Future<Result<bool>> signUpUser(SignUpModel user);
   Future<Result<SignUpModel>> loginUser(String email, String password);
}