import 'package:movie_app/model/rating.dart';

class Movie {
  Movie({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbId,
    required this.type,
    required this.dvd,
    required this.boxOffice,
    required this.production,
    required this.website,
    required this.response,
  });

  final String title;
  final String year;
  final String rated;
  final String released;
  final String runtime;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final List<Rating> ratings;
  final String metascore;
  final String imdbRating;
  final String imdbVotes;
  final String imdbId;
  final String type;
  final String dvd;
  final String boxOffice;
  final String production;
  final String website;
  final String response;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        title: json["Title"] ?? '',
        year: json["Year"] ?? '',
        rated: json["Rated"] ?? '',
        released: json["Released"] ?? '',
        runtime: json["Runtime"] ?? '',
        genre: json["Genre"] ?? '',
        director: json["Director"] ?? '',
        writer: json["Writer"] ?? '',
        actors: json["Actors"] ?? '',
        plot: json["Plot"] ?? '',
        language: json["Language"] ?? '',
        country: json["Country"] ?? '',
        awards: json["Awards"] ?? '',
        poster: json["Poster"] ?? '',
        ratings: json["Ratings"] != null
            ? List<Rating>.from(json["Ratings"].map((x) => Rating.fromJson(x)))
            : [],
        metascore: json["Metascore"] ?? '',
        imdbRating: json["imdbRating"] ?? '',
        imdbVotes: json["imdbVotes"] ?? '',
        imdbId: json["imdbID"] ?? '',
        type: json["Type"] ?? '',
        dvd: json["DVD"] ?? '',
        boxOffice: json["BoxOffice"] ?? '',
        production: json["Production"] ?? '',
        website: json["Website"] ?? '',
        response: json["Response"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "Rated": rated,
        "Released": released,
        "Runtime": runtime,
        "Genre": genre,
        "Director": director,
        "Writer": writer,
        "Actors": actors,
        "Plot": plot,
        "Language": language,
        "Country": country,
        "Awards": awards,
        "Poster": poster,
        "Ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
        "Metascore": metascore,
        "imdbRating": imdbRating,
        "imdbVotes": imdbVotes,
        "imdbID": imdbId,
        "Type": type,
        "DVD": dvd,
        "BoxOffice": boxOffice,
        "Production": production,
        "Website": website,
        "Response": response,
      };
}
