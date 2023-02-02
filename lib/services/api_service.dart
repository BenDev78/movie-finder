import 'package:dio/dio.dart';
import 'package:movie_finder/models/movie.dart';
import 'package:movie_finder/services/api.dart';

class ApiService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    String url = api.baseURL + path;

    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR'
    };

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
    Response response = await getData('movie/popular', params: {'page': pageNumber});

    if (200 == response.statusCode) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];

      for (Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    }

    throw response;
  }
}