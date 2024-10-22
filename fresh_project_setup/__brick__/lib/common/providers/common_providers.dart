import 'package:{{package_name}}/core/repository/hive_repository.dart';
import 'package:{{package_name}}/network/api_client.dart';
import 'package:{{package_name}}/network/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final hiveRepositoryProvider = Provider<HiveRepository>((ref) => HiveRepository(ref));

final bottomNavigationIndexProvider = StateProvider<int>((ref) => 0);

final userAuthTokenProvider = StateProvider<String>((ref) {
  return ref.read(hiveRepositoryProvider).getUserAccountToken;
}); 

final isUserLoggedInProvider = StateProvider<bool>((ref) {
  ref.watch(userAuthTokenProvider);
  return ref.read(hiveRepositoryProvider).getIsUserLoggedIn;
});



final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = Dio(); // Provide a dio instance
  dio.interceptors.add(TokenInterceptor(ref: ref));
  if(!kReleaseMode) {
    dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90
        )
    );
  }
  return ApiClient(dio);
});






