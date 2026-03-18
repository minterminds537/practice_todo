import 'package:practice/core/base/result.dart';

abstract class UseCase<T> {
  Future<Result<T>> call();
}

abstract class UseCaseWithParams<T, Params> {
  Future<Result<T>> call(Params params);
}

abstract class StreamUseCase<T> {
  Stream<Result<T>> call();
}

abstract class StreamUseCaseWithParams<T, Params> {
  Stream<Result<T>> call(Params params);
}