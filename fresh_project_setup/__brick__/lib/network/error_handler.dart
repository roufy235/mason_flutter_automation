import 'package:{{package_name}}/common/models/laravel_error_response.dart';
import 'package:{{package_name}}/config/config.dart';
import 'package:{{package_name}}/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorised = 401; // failure, user is not authorised
  static const int forbidden = 403; //  failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, not found

  // local status code
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponseMessage {
  static const String success = AppStrings.kNetworkSuccess; // success with data
  static const String noContent = AppStrings.kNetworkSuccess; // success with no data (no content)
  static const String badRequest = AppStrings.kNetworkBadRequestError; // failure, API rejected request
  static const String unauthorised = AppStrings.kNetworkUnauthorizedError; // failure, user is not authorised
  static const String forbidden = AppStrings.kNetworkForbiddenError; //  failure, API rejected request
  static const String internalServerError = AppStrings.kNetworkInternalServerError; // failure, crash in server side
  static const String notFound = AppStrings.kNetworkNotFoundError; // failure, crash in server side

  // local status code
  static const String connectTimeout = AppStrings.kNetworkTimeoutError;
  static const String cancel = AppStrings.kNetworkCancel;
  static const String receiveTimeout = AppStrings.kNetworkTimeoutError;
  static const String sendTimeout = AppStrings.kNetworkTimeoutError;
  static const String cacheError = AppStrings.kNetworkCacheError;
  static const String noInternetConnection = AppStrings.kNetworkNoInternetError;
  static const String defaultError = AppStrings.kNetworkDefaultError;
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:return Failure(code: ResponseCode.success, message: ResponseMessage.success);
      case DataSource.noContent:return Failure(code: ResponseCode.noContent, message: ResponseMessage.noContent);
      case DataSource.badRequest:return Failure(code: ResponseCode.badRequest, message: ResponseMessage.badRequest);
      case DataSource.forbidden:return Failure(code: ResponseCode.forbidden, message: ResponseMessage.forbidden);
      case DataSource.unauthorised:return Failure(code: ResponseCode.unauthorised, message: ResponseMessage.unauthorised);
      case DataSource.notFound:return Failure(code: ResponseCode.notFound, message: ResponseMessage.notFound);
      case DataSource.internalServerError:return Failure(code: ResponseCode.internalServerError, message: ResponseMessage.internalServerError);
      case DataSource.connectTimeout:return Failure(code: ResponseCode.connectTimeout, message: ResponseMessage.connectTimeout);
      case DataSource.cancel:return Failure(code: ResponseCode.cancel, message: ResponseMessage.cancel);
      case DataSource.receiveTimeout:return Failure(code: ResponseCode.receiveTimeout, message: ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:return Failure(code: ResponseCode.sendTimeout, message: ResponseMessage.sendTimeout);
      case DataSource.cacheError:return Failure(code: ResponseCode.cacheError, message: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:return Failure(code: ResponseCode.noInternetConnection, message: ResponseMessage.noInternetConnection);
      case DataSource.defaultError:return Failure(code: ResponseCode.defaultError, message: ResponseMessage.defaultError);
    }
  }
}



class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout: return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout: return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout: return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null && error.response?.statusCode != null && error.response?.statusMessage != null) {
        final map = error.response!.data as Map<String, dynamic>;

        if (error.response != null && [400, 401, 409].contains(error.response?.statusCode)) {
          // Regular expression to match SQLSTATE code
          final RegExp regex = RegExp(r'SQLSTATE\[\d+\]');
          try {
            LaravelErrorResponse errorLaravel = LaravelErrorResponse.fromJson(map);
            String errorMsg = errorLaravel.message.toString();
            // Check if the string contains SQLSTATE code
            if (regex.hasMatch(errorMsg)) {
              return Failure(code: error.response?.statusCode ?? 0, message: AppStrings.kNetworkDefaultError);
            }
            if (errorMsg.toLowerCase() == 'server error') {
              return Failure(code: error.response?.statusCode ?? 0, message: AppStrings.kNetworkDefaultError);
            }
            return Failure(code: error.response?.statusCode ?? 0, message: errorMsg);
          } catch(_) {
            String errorMsg = '';
            try {
              final message = map['message'];
              if (message is String) {
                errorMsg = message;
              } else {
                final message = map['message'] as Map<String, dynamic>;
                message.forEach((mapKey, value) {
                  errorMsg = value[0];
                });
              }
            } catch(_) {
              errorMsg = map['message'].toString();
            }
            // Check if the string contains SQLSTATE code
            if (regex.hasMatch(errorMsg)) {
              return Failure(code: error.response?.statusCode ?? 0, message: AppStrings.kNetworkDefaultError);
            } else {
              return Failure(code: error.response?.statusCode ?? 0, message: errorMsg);
            }
          }
        }

        if (error.response != null && [403, 404, 405].contains(error.response?.statusCode)) {
          String errorMsg = '';
          try {
            final message = map['message'];
            if (message is String) {
              errorMsg = message;
            } else {
              final Map<String, dynamic> message = Map<String, dynamic>.from(map['message']);
              message.forEach((mapKey, value) {
                errorMsg = value[0].toString();
              });
            }
          } catch(e) {
            errorMsg = 'an error has occurred';
          }
          return Failure(code: error.response?.statusCode ?? 0, message: errorMsg);
        }

        if (error.response != null && [500].contains(error.response?.statusCode)) {
          return Failure(code: error.response?.statusCode ?? 0, message: AppStrings.kNetworkInternalServerError);
        }

        if (error.response != null) {
          if (map.containsKey('message') && map['message'] != null) {
            String errorMsg = map['message'].toString();
            return Failure(code: error.response?.statusCode ?? 0, message: errorMsg);
          }
        }

        return DataSource.defaultError.getFailure();
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.cancel:return DataSource.cancel.getFailure();
    default:return DataSource.defaultError.getFailure();
  }
}
