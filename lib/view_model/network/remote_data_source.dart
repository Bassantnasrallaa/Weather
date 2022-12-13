import 'package:dio/dio.dart';
import 'package:elgaw/core/api_constant.dart';

class WeatherDio {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      baseUrl: ApiConstant.apiUrl,
    ));
  }

  static Future<Response> getData({
    required String url,
     Map<String, dynamic>? queryParameters,
  })async {
    {
      try {
        dio!.options.headers = {
          'appid': ApiConstant.apiKey,
        };
        final Response response = await dio!.get(
          url,
          queryParameters: queryParameters,
        );
        return response;
      } catch (e) {
        rethrow;
      }
    }
  }
}
