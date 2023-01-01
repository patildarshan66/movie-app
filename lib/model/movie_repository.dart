import 'package:movie_app/model/services/base_service.dart';
import 'package:movie_app/model/services/movie_service.dart';

import 'movie.dart';
import 'movies_res_data.dart';


class MovieRepository {
  final BaseService _movieService = MovieService();

  Future<List<MovieData>> fetchMoviesList(String endpoint) async {
    dynamic response = await _movieService.getResponse(endpoint);
    List<MovieData> moviesList = List<MovieData>.from(response['Search'].map((tagJson) => MovieData.fromJson(tagJson)));
    return moviesList;
  }

  Future<Movie> fetchMovieDetails(String endpoint) async {
    dynamic response = await _movieService.getResponse(endpoint);
    Movie movie = Movie.fromJson(response);
    return movie;
  }
}
