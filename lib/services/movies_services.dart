import 'package:get_it/get_it.dart';
import 'package:movie_app/services/http_services.dart';

class MoviesServices {
  final GetIt getIt = GetIt.instance;
  late HTTPServices _httpServices;

  MoviesServices() {
    _httpServices = getIt.get<HTTPServices>();
  }
}
