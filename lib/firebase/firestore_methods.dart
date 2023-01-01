import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_app/model/movies_res_data.dart';

class FirestoreMethods {
  static const String repoName = 'movie-history';
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<List<MovieData>> getMoviesHistoryList() async {
    try{
      final result  = await firestore.collection(repoName).get();
      final docs = result.docs;
      List<MovieData> historyList = [];
      for (var element in docs) {
        historyList.add(MovieData.fromJson(element.data()));
      }
      return historyList;
    }catch(e){
      rethrow;
    }
  }

  static Future<void> addMovieToHistoryList(MovieData data) async {
    try{
      await firestore.collection(repoName).doc(data.title).set(data.toJson());
    }catch(e){
      rethrow;
    }
  }

}