import 'enums.dart';

class AppError {
  final ErrorType type;
  final String message;

  AppError({required this.type, required this.message});
}