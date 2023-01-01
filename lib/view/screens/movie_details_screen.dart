import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/movie.dart';
import '../../utils/colors.dart';
import '../../utils/custom_dimensions.dart';
import '../../utils/custom_text_styles.dart';
import '../../utils/enums.dart';
import '../../view_model/movie_view_model.dart';
import '../widgets/shimmer_loader.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String imdbId;
  const MovieDetailsScreen({Key? key, required this.imdbId}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final MovieViewModel _movieViewModel = Get.find<MovieViewModel>();

  @override
  void initState() {
    _movieViewModel.getMovieDetails(widget.imdbId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: GetBuilder(
          init: _movieViewModel,
          builder: (controller) {
            return _getBody(height);
          },
        ),
      ),
    );
  }

  Widget _getBody(double height) {
    switch (_movieViewModel.response.status) {
      case Status.COMPLETED:
        final Movie? movie = _movieViewModel.movieDetails;
        List<String> generic = movie?.genre.split(',') ?? [];
        return _movieViewModel.movieDetails != null
            ? Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: height * 0.6,
                    width: double.infinity,
                    imageUrl: movie?.poster ?? '',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => ImageShimmerLoader(
                      width: double.infinity,
                      height: height * 0.6,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: height * 0.6,
                      child: const Icon(
                        Icons.error,
                        color: errorColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: px_16,
                    left: px_16,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: px_40,
                        width: px_40,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(px_20),
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                  Container(
                    height: height,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: spacing_xxl_2, vertical: spacing_xxl_6),
                    margin: EdgeInsets.only(
                      top: height * 0.4,
                      left: spacing_xxl_2,
                      right: spacing_xxl_2,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radius_large),
                          topLeft: Radius.circular(radius_large)),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          greyBlackColor,
                          Color(0xff232220),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          movie?.title ?? '',
                          style: h3_24ptBold(color: whiteColor),
                        ),
                        const SizedBox(height: spacing_x6),
                        Row(
                          children: [
                            const Icon(Icons.star_border_rounded,
                                color: greyColor),
                            const SizedBox(width: 2),
                            Text(
                              movie?.metascore ?? '0',
                              style: caption12ptMedium(color: whiteColor),
                            ),
                            const SizedBox(width: spacing_xxl_7),
                            const Icon(Icons.schedule_rounded,
                                color: greyColor),
                            const SizedBox(width: 2),
                            Text(
                              movie?.runtime ?? '0',
                              style: caption12ptMedium(color: whiteColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: spacing_xxl_8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movie?.type ?? '',
                              style: h4_20ptMedium(color: whiteColor),
                            ),
                            const SizedBox(width: px_20),
                            Flexible(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ...generic
                                        .map((e) => _chipWidget(e))
                                        .toList(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: spacing_m),
                        const Divider(
                          thickness: 5,
                          color: Color(0xff7b7b7b),
                        ),
                        const SizedBox(height: spacing_m),
                        Text(
                          movie?.plot ?? '',
                          style: subTitle2_14ptRegular(
                              color: Colors.white, height: 1.7),
                        ),
                        const SizedBox(height: spacing_xxl_6),
                        _rowTitleValue('Director', movie?.director ?? ''),
                        const SizedBox(height: spacing_m),
                        _rowTitleValue('Writer', movie?.writer ?? ''),
                        const SizedBox(height: spacing_m),
                        _rowTitleValue('Actors', movie?.actors ?? ''),
                      ],
                    ),
                  ),
                ],
              )
            : Container();
      case Status.ERROR:
      case Status.NOINTERNET:
        return Center(
          child: Text(_movieViewModel.response.message ?? ''),
        );
      case Status.LOADING:
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  Widget _rowTitleValue(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$title: ',
          style: subTitle2_14ptRegular(color: whiteColor),
        ),
        Expanded(
          child: Text(
            value,
            style: subTitle2_14ptRegular(color: whiteColor),
          ),
        ),
      ],
    );
  }

  Widget _chipWidget(String title) {
    return Container(
      height: px_25,
      margin: const EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: px_10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.5),
        color: const Color(0xffaaaaa8),
      ),
      child: Text(
        title.trim(),
        style: subTitle2_14ptRegular(color: whiteColor),
      ),
    );
  }
}
