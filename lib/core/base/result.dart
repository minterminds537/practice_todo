class Result<T> {
  final T? data;
  final String? message;
  final int? statusCode;
  final bool isSuccess;

  const Result._({
    this.data,
    this.message,
    this.statusCode,
    required this.isSuccess,
  });

  factory Result.success({
    required T data,
    int? statusCode,
    String? message,
  }) {
    return Result._(
      data: data,
      message: message,
      statusCode: statusCode,
      isSuccess: true,
    );
  }

  factory Result.failure({
    String? message,
    int? statusCode,
  }) {
    return Result._(
      data: null,
      message: message ?? "Something went wrong",
      statusCode: statusCode,
      isSuccess: false,
    );
  }
}