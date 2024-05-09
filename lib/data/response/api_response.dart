import 'package:mvvm/data/response/Status.dart';

class ApiResponse<T> {
  late Status? status;
  final T? data;
  final String? message;

  ApiResponse(this.status, this.data, this.message);

  factory ApiResponse.loading() {
    return ApiResponse(Status.LOADING, null, null);
  }

  factory ApiResponse.completed(T data) {
    return ApiResponse(Status.COMPLETED, data, null);
  }

  factory ApiResponse.error(String message) {
    return ApiResponse(Status.ERROR, null, message);
  }

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
