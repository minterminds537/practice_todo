import '../../../../core/base/base_use_case.dart';
import '../../../../core/base/result.dart';
import '../../data/models/sign_up_model.dart';
import '../entities/user.dart';
import '../repo/auth_repo.dart';

class LoginUseCase extends UseCaseWithParams<SignUpModel?, LoginParams>{

  final AuthRepo _authRepo;
  LoginUseCase({required AuthRepo authRepo}) : _authRepo = authRepo;

  @override
  Future<Result<SignUpModel?>> call(LoginParams params) {
    return _authRepo.loginUser(params.email!, params.password!);
  }

}