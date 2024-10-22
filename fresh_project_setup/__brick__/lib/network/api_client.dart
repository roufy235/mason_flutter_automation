import 'dart:io';
import 'package:{{package_name}}/network/api_path.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiPath.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(ApiPath.registerUser)
  Future<String> registerUser(@Body() String requestModel);

}
