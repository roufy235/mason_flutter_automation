import 'dart:convert';

import 'package:{{package_name}}/common/providers/common_providers.dart';
import 'package:{{package_name}}/common/providers/invalid_token_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenInterceptor extends Interceptor {

  final Ref ref;
  TokenInterceptor({required this.ref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String authToken = ref.read(userAuthTokenProvider);
    // After you choose your token, you assign it to the request.
    options.headers["Accept"] = 'application/json';
    options.headers["Content-Type"] = 'application/json';
    options.headers['Authorization'] = 'Bearer $authToken';
    //options.headers["Content-Type"] = 'application/json; charset=UTF-8; multipart/form-data';
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // // If the error is 401 Unauthorized, log out the user
    // if (err.response?.statusCode == 401) {
    //   _repository.logOut();
    //   _appDatabase.userDao.deleteAllUsers();
    // }
    if (err.type == DioExceptionType.badResponse) {
      try {
        if (err.response!.statusCode == 401) { // Unauthorized
          Map<String, dynamic> response = jsonDecode(err.response.toString());
          if (response.containsKey('message') && response['message'].toLowerCase() == 'unauthenticated.') {
            ref.read(hiveRepositoryProvider).signOut();
            ref.read(invalidTokenProvider.notifier).toggle(true);
            return;
          }
          if (response.containsKey('error') && response['error'].toLowerCase() == 'unauthenticated') {
            ref.read(hiveRepositoryProvider).signOut();
            ref.read(invalidTokenProvider.notifier).toggle(true);
            return;
          }
        }
      } catch(_) {}
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Do something with response data
    super.onResponse(response, handler);
  }

}
