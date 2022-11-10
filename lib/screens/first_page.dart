import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/models/search_categories.dart';

import '../business_logic/movies_cubit.dart';
import '../models/movie.dart';
import '../widgets/movie_tile.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  double? _deviceWidth;
  double? _deviceHieght;
  TextEditingController? _searchTextEditingController;
  // List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesCubit>(context).getMovies();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHieght = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _searchTextEditingController = TextEditingController();
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (BuildContext context, state) {
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
        height: _deviceHieght,
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
      height: _deviceHieght,
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
      padding: EdgeInsets.fromLTRB(0, (_deviceHieght! * 0.07), 0, 0),
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
      height: _deviceHieght! * 0.08,
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
      height: _deviceHieght! * 0.05,
      child: TextField(
        onSubmitted: (value) {},
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
      value: SearchCategories.popular,
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
      onChanged: (dynamic value) {},
    );
  }

  Widget _moviesListViewWidget() {
    final List<Movie> movies = BlocProvider.of<MoviesCubit>(context).movies;

    if (movies.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: _deviceHieght! * 0.01),
            child: GestureDetector(
              onTap: () {},
              child: MovieTile(
                movie: movies[index],
                height: _deviceHieght! * 0.20,
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
