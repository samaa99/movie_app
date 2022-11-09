import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/app_config.dart';

class HTTPServices {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _baseUrl;
  late String _apiKey;

  HTTPServices() {
    AppConfig config = getIt.get<AppConfig>();
    _baseUrl = config.BASE_API_URL;
    _apiKey = config.API_KEY;
  }

  Future<Response?> get(String path, {Map<String, dynamic>? query}) async {
    try {
      String url = '$_baseUrl$path';
      Map<String, dynamic> queries = {
        'api_key': _apiKey,
        'language': 'en-US',
      };
      if (query != null) {
        queries.addAll(query);
      }
      return await dio.get(url, queryParameters: queries);
    } on DioError catch (e) {
      print('Unable to perform get request.');
      print('DioError:$e');
    }
  }
}
