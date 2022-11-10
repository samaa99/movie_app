import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/http_services.dart';

class MoviesServices {
  final GetIt getIt = GetIt.instance;
  late HTTPServices _httpServices;

  MoviesServices() {
    _httpServices = getIt.get<HTTPServices>();
  }

  Future<List<dynamic>> getMovies({int? page}) async {
    Response? response = await _httpServices.get('/movie/popular', query: {
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map data = response.data;
      return data['results'];
    } else {
      throw Exception('Couldn\'t load popular movies.');
    }
  }

  Future<List<Movie>?> getPopularMovies({int? page}) async {
    Response? response = await _httpServices.get('/movie/popular', query: {
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map data = response.data;
      List<Movie>? movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load popular movies.');
    }
  }

  Future<List<Movie>?> getUpcomingMovies({int? page}) async {
    Response? response = await _httpServices.get('/movie/upcoming', query: {
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map data = response.data;
      List<Movie>? movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load upcoming movies.');
    }
  }

  Future<List<Movie>?> searchMovies(String searchTerm, {int? page}) async {
    Response? response = await _httpServices.get('/search/movie', query: {
      'query': searchTerm,
      'page': page,
    });
    if (response!.statusCode == 200) {
      Map data = response.data;
      List<Movie>? movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t perform search.');
    }
  }
}
