class BaseState<T> {
  bool isLoading;
  bool isSuccess;
  dynamic error;
  T? data;

  BaseState(
      {this.isLoading = false, this.isSuccess = false, this.error, this.data});

  get hasData => this.isSuccess && this.data != null;

  get hasError => error != null && error!.message.isNotEmpty;

  BaseState<T> copyWith(
      {bool? isLoading, bool? isSuccess = false, BaseError? error, T? data}) {
    return BaseState<T>(
      data: data,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }
}

class BaseError {
  final String massage;
  final ErrorType type;
  BaseError(this.massage, {this.type = ErrorType.apiError});
}

enum ErrorType {
  apiError,
  validationError,
}
