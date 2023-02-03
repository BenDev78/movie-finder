import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_finder/services/api_service.dart';
import '../models/movie.dart';

class DataRepository with ChangeNotifier {
  final ApiService apiService = ApiService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;

  final List<Movie> _nowPlayingMovieList = [];
  int _nowPlayingMoviePageIndex = 1;

  final List<Movie> _upcomingMovieList = [];
  int _upcomingMoviePageIndex = 1;

  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlayingMovieList => _nowPlayingMovieList;
  List<Movie> get upcomingMovieList => _upcomingMovieList;

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

  Future<void> getNowPlayingMovieList() async {
    try {
      List<Movie> movies = await apiService.getNowPlayingMovie(
          pageNumber: _nowPlayingMoviePageIndex);
      _nowPlayingMovieList.addAll(movies);
      _nowPlayingMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> getUpcomingMovieList() async {
    try {
      List<Movie> movies = await apiService.getUpcomingMovies(
          pageNumber: _upcomingMoviePageIndex);
      _upcomingMovieList.addAll(movies);
      _upcomingMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<Movie> getMovie({required Movie movie}) async {
    try {
      Movie newMovie = await apiService.getMovie(movie: movie);
      newMovie = await apiService.getMovieVideos(movie: newMovie);

      return newMovie;
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> initData() async {
    await Future.wait([
      getPopularMovieList(),
      getNowPlayingMovieList(),
      getUpcomingMovieList()
    ]);
  }
}
