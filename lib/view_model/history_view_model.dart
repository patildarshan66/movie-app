import 'package:get/get.dart';
import 'package:movie_app/firebase/firestore_methods.dart';
import 'package:movie_app/model/movies_res_data.dart';
import '../model/apis/api_response.dart';
import '../model/services/urls.dart';
import '../model/movie.dart';
import '../model/movie_repository.dart';
import '../utils/utils.dart';

class HistoryViewModel extends GetxController {
  final MovieRepository _movieRepository = MovieRepository();
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  List<MovieData>  _moviesHistoryList = [];

  List<MovieData> get moviesHistoryList {
    return _moviesHistoryList;
  }

  ApiResponse get response {
    return _apiResponse;
  }

  Future<void> getSearchHistory() async {
    await isConnected().then((value) async {
      _apiResponse = ApiResponse.loading('Data Received');
      update();
      try{
        _moviesHistoryList = await FirestoreMethods.getMoviesHistoryList();
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

  Future<void> addMovieToHistory(MovieData data) async {
    await isConnected().then((value) async {
      try{
        await FirestoreMethods.addMovieToHistoryList(data);
      }catch(e){
        customPrinter(e.toString());
        showSnackBar(e.toString(), title: 'Error');
      }
    }).onError((error, stackTrace){
      customPrinter(error.toString());
      showSnackBar(error.toString(), title: 'Error');
    });
  }

}