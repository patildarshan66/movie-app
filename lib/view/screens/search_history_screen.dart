import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/custom_dimensions.dart';
import '../../utils/custom_text_styles.dart';
import '../../utils/enums.dart';
import '../../view_model/history_view_model.dart';
import '../widgets/movie_grid.dart';

class SearchHistoryScreen extends StatefulWidget {
  const SearchHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SearchHistoryScreen> createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends State<SearchHistoryScreen> {
  final HistoryViewModel _historyViewModel = Get.put(HistoryViewModel());

  @override
  void initState() {
    _historyViewModel.getSearchHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(spacing_xxl_4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Browse',
                        style: h2_32ptBold(color: whiteColor),
                      ),
                      Text(
                        'History',
                        style: subTitle2_14ptRegular(color: greyColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: spacing_xxl_14),
              Expanded(
                child: GetBuilder(
                  init: _historyViewModel,
                  builder: (controller) {
                    return _getBody(width, height);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getBody(double width, double height) {
    switch (_historyViewModel.response.status) {
      case Status.COMPLETED:
        return _historyViewModel.moviesHistoryList.isNotEmpty
            ? GridView.builder(
                itemCount: _historyViewModel.moviesHistoryList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: spacing_xxl_2,
                  mainAxisSpacing: spacing_xxl_2,
                  childAspectRatio: (width / height),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return MovieGrid(
                      movieData: _historyViewModel.moviesHistoryList[index]);
                },
              )
            : Center(
                child: Text(
                'No Search History Available',
                style: h4_20ptRegular(color: whiteColor),
              ));
      case Status.ERROR:
      case Status.NOINTERNET:
        return Center(
          child: Text(_historyViewModel.response.message ?? ''),
        );
      case Status.LOADING:
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
