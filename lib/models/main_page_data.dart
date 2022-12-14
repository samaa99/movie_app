import 'package:movie_app/models/search_categories.dart';

import 'movie.dart';

class MainPageData {
  final List<Movie>? movies;
  final int? page;
  final String? searchCategory;
  final String? searchText;

  MainPageData({this.movies, this.page, this.searchCategory, this.searchText});

  MainPageData.initial()
      : movies = [],
        page = 1,
        searchCategory = SearchCategories.popular,
        searchText = '';

  MainPageData copyWith(
      {List<Movie>? movies,
      int? page,
      String? searchCategory,
      String? searchText}) {
    return MainPageData(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
    );
  }
}
