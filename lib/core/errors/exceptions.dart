import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;

  const ServerException(this.message);

  @override
  List<Object?> get props => [message];

 
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super("Error During Communication");
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super("Bad Request");
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super("Unauthorized");
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super("Requested Info Not Found");
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super("Conflict Occurred");
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message]) : super("Internal Server Error");
}

class NoInternetConnectionException extends ServerException {
  
  const NoInternetConnectionException([message]) : super("No Internet Connection");
}

class UnknowError extends ServerException {
  const UnknowError([message]) : super("OOPS..Unknow Error");
}

class CacheException extends ServerException implements Exception {
  const CacheException([message]) : super("OOPS..Cache Error");
}


