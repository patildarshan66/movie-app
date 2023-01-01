import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/model/movies_res_data.dart';
import 'package:movie_app/routes/route_strings.dart';
import 'package:movie_app/view/widgets/shimmer_loader.dart';
import 'package:movie_app/view_model/history_view_model.dart';

import '../../utils/colors.dart';
import '../../utils/custom_dimensions.dart';
import '../../utils/custom_text_styles.dart';

class MovieGrid extends StatelessWidget {
  final MovieData movieData;
  const MovieGrid({Key? key, required this.movieData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        Get.toNamed(RoutePath.movieDetailsRoute,arguments: movieData.imdbId);
        HistoryViewModel().addMovieToHistory(movieData);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(margin_semi_normal),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 143,
              width: width * 0.25,
              imageUrl: movieData.poster,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  ImageShimmerLoader(height: 143, width: width * 0.25),
              errorWidget: (context, url, error) => Container(
                height: 143,
                width: width * 0.25,
                color: Colors.white,
                alignment: Alignment.center,
                child: const Icon(Icons.error, color: errorColor),
              ),
            ),
          ),
          const SizedBox(height: spacing_x6),
          Text(
            movieData.title,
            style: overLine10ptMedium(color: whiteColor),
          ),
          const SizedBox(height: spacing_xs),
          Text(
            movieData.year,
            style: overLine10ptRegular(color: whiteColor),
          )
        ],
      ),
    );
  }
}
