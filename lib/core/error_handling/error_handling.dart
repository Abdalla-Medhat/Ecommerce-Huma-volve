import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/failure/failure.dart';

class ErrorHandler {
  static Failure errorHandler(dynamic error) {
    if (error is DioException) {
      return errorHandling(error.toString());
    }
    return Failure(failureMessage: "Unexpected Error");
  }

  static Failure errorHandling(String message) {
    final errorMessage = message.toLowerCase().trim();
    if (errorMessage.contains("401") ||
        errorMessage.contains("unauthorized") ||
        errorMessage.contains("Unauthenticated")) {
      return const Failure(failureMessage: "Unauthorized");
    }
    if (errorMessage.contains("404") || errorMessage.contains("not found")) {
      return const Failure(failureMessage: "Not Found");
    }
    if (errorMessage.contains("400") || errorMessage.contains("bad request")) {
      return const Failure(failureMessage: "Bad Request");
    }
    if (errorMessage.contains("403") || errorMessage.contains("forbidden")) {
      return const Failure(failureMessage: "Forbidden");
    }
    if (errorMessage.contains("409") || errorMessage.contains("conflict")) {
      return const Failure(failureMessage: "Conflict");
    }
    if (errorMessage.contains("500") || errorMessage.contains("server error")) {
      return const Failure(failureMessage: "Server Error");
    }
    if (errorMessage.contains("timeout")) {
      return const Failure(failureMessage: "Timeout");
    }
    if (errorMessage.contains("socketexception") ||
        errorMessage.contains("connection failed") ||
        errorMessage.contains("handshakeexception")) {
      return const Failure(failureMessage: "No Internet Connection");
    }
    if (errorMessage.contains("typeerror") ||
        errorMessage.contains("formatexception")) {
      return const Failure(failureMessage: "Bad Format");
    }
    return const Failure(failureMessage: "Un Known Error");
  }
}
