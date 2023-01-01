import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/view/screens/movie_details_screen.dart';
import 'package:movie_app/view/screens/movies_screen.dart';
import 'package:movie_app/view/screens/search_history_screen.dart';
import 'route_strings.dart';

class AppRoutes {
  Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.movieDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(
              imdbId: routeSettings.arguments as String,
          ),
        );
      case RoutePath.searchHistoryRoute:
        return MaterialPageRoute(
          builder: (_) => const SearchHistoryScreen(),
        );
      case RoutePath.moviesScreen:
      default:
        return MaterialPageRoute(builder: (_) => const MoviesScreen());
    }
  }
}
