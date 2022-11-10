import 'package:get_it/get_it.dart';
import 'package:movie_app/models/main_page_data.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/search_categories.dart';
import 'package:movie_app/services/movies_services.dart';
import 'package:riverpod/riverpod.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  final MoviesServices _movieService = GetIt.instance.get<MoviesServices>();
  Future getMovies() async {
    try {
      List<Movie>? _movies = [];
      if (state.searchText!.isEmpty) {
        if (state.searchCategory == SearchCategories.popular) {
          _movies = await _movieService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategories.upcoming) {
          _movies = await _movieService.getUpcomingMovies(page: state.page);
        } else if (state.searchCategory == SearchCategories.none) {
          _movies = [];
        }
      } else {
        _movies = await _movieService.searchMovies(state.searchText!);
      }
      state = state.copyWith(
          movies: [...state.movies!, ..._movies!], page: state.page! + 1);
    } catch (e) {
      print(e);
    }
  }

  void updateSearchCategory(String category) {
    try {
      state = state.copyWith(
          movies: [], page: 1, searchCategory: category, searchText: '');
      getMovies();
    } catch (e) {
      print(e);
    }
  }

  void updateTextSearch(String searchTerm) {
    try {
      state = state.copyWith(
          movies: [],
          page: 1,
          searchCategory: SearchCategories.none,
          searchText: searchTerm);
      getMovies();
    } catch (e) {
      print(e);
    }
  }
}
