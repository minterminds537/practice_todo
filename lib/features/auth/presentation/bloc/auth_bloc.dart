import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice/features/auth/domain/entities/user.dart';
import '../../domain/use_cases/login.dart';
import '../../domain/use_cases/singup.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required SignUpUseCase signUpUseCase})

      : _loginUseCase = loginUseCase, _signUpUseCase = signUpUseCase, super(SignUpInitial()){
    on<SignUpEvent>(_onSignUp);
    on<LoginEvent>(_onLoginLoading);

  }

  void _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(SignUpLoading());
    var result= await _signUpUseCase.call(event.user);
    if(result.isSuccess == true){
      emit(SignUpSuccess(isSuccess: true));
    }else{
      emit(SignUpFailure(message: result.message!));
    }
  }

  void _onLoginLoading(LoginEvent event, Emitter<AuthState> emit) async {
    emit(SignUpLoading());
    var result= await _loginUseCase.call(LoginParams(email: event.email, password: event.password));
    if(result.isSuccess == true){
      emit(LoginSuccess(user: result.data!));
    }else{
      emit(LoginFailure(message: result.message!));
    }
  }


  }