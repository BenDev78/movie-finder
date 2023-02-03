import 'package:dio/dio.dart';
import 'package:movie_finder/models/movie.dart';
import 'package:movie_finder/services/api.dart';

class ApiService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    String url = api.baseURL + path;

    Map<String, dynamic> query = {'api_key': api.apiKey, 'language': 'fr-FR'};

    if (null != params) {
      query.addAll(params);
    }

    final response = await dio.get(url, queryParameters: query);

    if (200 == response.statusCode) {
      return response;
    }

    throw response;
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response =
        await getData('movie/popular', params: {'page': pageNumber});

    if (200 == response.statusCode) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json) {
        return Movie.fromJson(json);
      }).toList();

      return movies;
    }

    throw response;
  }

  Future<List<Movie>> getNowPlayingMovie({required int pageNumber}) async {
    Response response =
        await getData('movie/now_playing', params: {'page': pageNumber});

    if (200 == response.statusCode) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json) {
        return Movie.fromJson(json);
      }).toList();

      return movies;
    }

    throw response;
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response =
        await getData('movie/upcoming', params: {'page': pageNumber});

    if (200 == response.statusCode) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic json) {
        return Movie.fromJson(json);
      }).toList();

      return movies;
    }

    throw response;
  }

  Future<Movie> getMovie({required Movie movie}) async {
    Response response = await getData('movie/${movie.id}');

    if (200 == response.statusCode) {
      Map<String, dynamic> data = response.data;
      var genres = data['genres'] as List;
      List<String> genresList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Movie newMovie = movie.copyWith(
          genres: genresList,
          releaseDate: data['release_date'],
          voteAverage: data['vote_average']);

      return newMovie;
    }

    throw response;
  }

  Future<Movie> getMovieVideos({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}/videos');

    if (200 == response.statusCode) {
      Map data = response.data;
      data['results'];
      List<String> videos = data['results'].map<String>((json) {
        return json['key'] as String;
      }).toList();

      return movie.copyWith(videos: videos);
    }

    throw response;
  }
}
