class MoviesResData {
  MoviesResData({
    required this.moviesList,
    required this.totalResults,
    required this.response,
  });

  final List<MovieData> moviesList;
  final String totalResults;
  final String response;

  factory MoviesResData.fromJson(Map<String, dynamic> json) => MoviesResData(
    moviesList: json["Search"]!=null ? List<MovieData>.from(json["Search"].map((x) => MovieData.fromJson(x))) : [],
    totalResults: json["totalResults"] ?? '',
    response: json["Response"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Search": List<dynamic>.from(moviesList.map((x) => x.toJson())),
    "totalResults": totalResults,
    "Response": response,
  };
}

class MovieData {
  MovieData({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
  });

  final String title;
  final String year;
  final String imdbId;
  final String type;
  final String poster;

  factory MovieData.fromJson(Map<String, dynamic> json) => MovieData(
    title: json["Title"] ?? '',
    year: json["Year"] ?? '',
    imdbId: json["imdbID"] ?? '',
    type: json["Type"] ?? '',
    poster: json["Poster"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Year": year,
    "imdbID": imdbId,
    "Type": type,
    "Poster": poster,
  };
}