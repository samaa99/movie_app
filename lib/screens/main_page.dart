import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/business_logic/movies_cubit.dart';
import 'package:movie_app/controllers/main_page_data_controller.dart';
import 'package:movie_app/models/main_page_data.dart';
import 'package:movie_app/models/search_categories.dart';

import '../models/movie.dart';
import '../widgets/movie_tile.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>(
        (ref) => MainPageDataController());

class MainPage extends ConsumerWidget {
  double? _deviceWidth;
  double? _deviceHeight;
  List<Movie> _movies = [];

  late MainPageDataController _mainPageDataController;
  late MainPageData _mainPageData;
  TextEditingController? _searchTextEditingController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _mainPageDataController =
        ref.watch(mainPageDataControllerProvider.notifier);
    _mainPageData = ref.watch(mainPageDataControllerProvider);

    _searchTextEditingController = TextEditingController();
    _searchTextEditingController?.text = _mainPageData.searchText!;

    //The same but with bloc
    BlocProvider.of<MoviesCubit>(context).getMovies();
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (BuildContext context, state) {
        _movies = BlocProvider.of<MoviesCubit>(context).movies;
        return _buildUI();
      },
    );
    // return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidgets(),
            _foregroundWidgets(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidgets() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: NetworkImage(
              'https://cdn.shopify.com/s/files/1/2533/3248/products/00873Moana_Blackstone__Rounded_900x_38e8023b-7362-4809-adcc-af6f10bc2c62_grande.png?v=1633520171'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _foregroundWidgets() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, (_deviceHeight! * 0.07), 0, 0),
      width: _deviceWidth! * 0.88,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          Expanded(child: _moviesListViewWidget()),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight! * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchTextField(),
          _categorySelectionMenu(),
        ],
      ),
    );
  }

  Widget _searchTextField() {
    return Container(
      width: _deviceWidth! * 0.5,
      height: _deviceHeight! * 0.05,
      child: TextField(
        onSubmitted: (value) => _mainPageDataController.updateTextSearch(value),
        controller: _searchTextEditingController,
        cursorColor: Colors.white24,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.white54),
          prefixIcon: Icon(Icons.search, color: Colors.white24),
          filled: false,
          fillColor: Colors.white24,
        ),
      ),
    );
  }

  Widget _categorySelectionMenu() {
    return DropdownButton<String>(
      dropdownColor: Colors.black38,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      value: _mainPageData.searchCategory,
      items: const [
        DropdownMenuItem(
          value: SearchCategories.popular,
          child: Text(
            SearchCategories.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategories.upcoming,
          child: Text(
            SearchCategories.upcoming,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategories.none,
          child: Text(
            SearchCategories.none,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
      onChanged: (dynamic value) => value.toString().isNotEmpty
          ? _mainPageDataController.updateSearchCategory(value!)
          : null,
    );
  }

  Widget _moviesListViewWidget() {
    //The same using bloc
    final List<Movie> movies = _movies;
    // final List<Movie> movies = _mainPageData.movies!;

    if (movies.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
            child: GestureDetector(
              onTap: () {},
              child: MovieTile(
                movie: movies[index],
                height: _deviceHeight! * 0.20,
                width: _deviceWidth! * 0.85,
              ),
            ),
          );
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
  }
}
