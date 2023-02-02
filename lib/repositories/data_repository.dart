import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/services/api_service.dart';
import '../models/movie.dart';

class DataRepository with ChangeNotifier {
  final ApiService apiService = ApiService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;

  List<Movie> get popularMovieList => _popularMovieList;

  Future<void> getPopularMovieList() async {
    try {
      List<Movie> movies =
          await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
        print("ERROR: ${response.statusCode}");
        rethrow;
    }
  }
}
