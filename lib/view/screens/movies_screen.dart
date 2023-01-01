import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/routes/route_strings.dart';
import 'package:movie_app/view/widgets/movie_grid.dart';
import 'package:movie_app/view_model/movie_view_model.dart';
import '../../utils/colors.dart';
import '../../utils/custom_dimensions.dart';
import '../../utils/custom_text_styles.dart';
import '../../utils/enums.dart';
import '../widgets/custom_drawer.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  final MovieViewModel _movieViewModel = Get.put(MovieViewModel());
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    ///no api available to show default movie list, that's why i call search api with marvel search keyword
    _movieViewModel.searchMovie('marvel');
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(spacing_xxl_4),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Browse',
                        style: h2_32ptBold(color: whiteColor),
                      ),
                      Text(
                        'Movies',
                        style: subTitle2_14ptRegular(color: greyColor),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu, color: whiteColor),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: lightBlackColor,
                  borderRadius: BorderRadius.circular(radius_small),
                ),
                margin: const EdgeInsets.only(
                    bottom: spacing_xxl_14, top: spacing_xxl_6),
                child: TextField(
                  controller: _searchController,
                  onSubmitted: _movieViewModel.searchMovie,
                  textInputAction: TextInputAction.search,
                  cursorColor: greyColor,
                  style: subTitle2_14ptRegular(color: greyColor),
                  decoration: InputDecoration(
                    hintText: 'Search movies',
                    hintStyle: subTitle2_14ptRegular(color: greyColor),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: blackColor),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: blackColor),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GetBuilder(
                  init: _movieViewModel,
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
    switch (_movieViewModel.response.status) {
      case Status.COMPLETED:
        return GridView.builder(
          itemCount: _movieViewModel.moviesList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: spacing_xxl_2,
            mainAxisSpacing: spacing_xxl_2,
            childAspectRatio: (width / height),
          ),
          itemBuilder: (BuildContext context, int index) {
            return MovieGrid(movieData: _movieViewModel.moviesList[index]);
          },
        );
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
}
