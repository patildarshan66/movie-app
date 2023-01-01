import 'package:get/get.dart';
import 'package:movie_app/model/movies_res_data.dart';
import '../model/apis/api_response.dart';
import '../model/services/urls.dart';
import '../model/movie.dart';
import '../model/movie_repository.dart';
import '../utils/utils.dart';

class MovieViewModel extends GetxController {
  final MovieRepository _movieRepository = MovieRepository();
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  List<MovieData>  _moviesList = [];

  Movie? _movieDetails;

  List<MovieData> get moviesList {
    return _moviesList;
  }

  Movie? get movieDetails {
    return _movieDetails;
  }

  ApiResponse get response {
    return _apiResponse;
  }

  Future<void> searchMovie(String movieName) async {
    await isConnected().then((value) async {
      _apiResponse = ApiResponse.loading('Data Received');
      update();
      try{
        _moviesList = await _movieRepository.fetchMoviesList(searchMovieUrl.replaceFirst('%s', movieName));
        _apiResponse = ApiResponse.completed('Data Received');
        update();
      }catch(e){
        _apiResponse = ApiResponse.error(e.toString());
        customPrinter(e.toString());
        showSnackBar(e.toString(), title: 'Error');
        update();
      }
    }).onError((error, stackTrace){
      _apiResponse = ApiResponse.notInternet('No internet connection!');
      update();
    });
  }

  Future<void> getMovieDetails(String id) async {
    await isConnected().then((value) async {
      _apiResponse = ApiResponse.loading('Data Received');
      update();
      try{
        _movieDetails = await _movieRepository.fetchMovieDetails(movieDetailsUrl.replaceFirst('%i', id));
        _apiResponse = ApiResponse.completed('Data Received');
        update();
      }catch(e){
        _apiResponse = ApiResponse.error(e.toString());
        customPrinter(e.toString());
        showSnackBar(e.toString(), title: 'Error');
        update();
      }
    }).onError((error, stackTrace){
      _apiResponse = ApiResponse.notInternet('No internet connection!');
      update();
    });
  }
}