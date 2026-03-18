  import 'package:practice/core/base/base_use_case.dart';
import 'package:practice/core/base/result.dart';
import 'package:practice/features/auth/data/models/sign_up_model.dart';
import '../repo/auth_repo.dart';

class SignUpUseCase extends UseCaseWithParams<bool, SignUpModel>{

  final AuthRepo _authRepo;
  SignUpUseCase({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  Future<Result<bool>> call(SignUpModel params) {
    return _authRepo.signUpUser(params);
  }

}