import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmerLoader extends StatelessWidget {
  final double height;
  final double width;
  const ImageShimmerLoader({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: height,
      height: width,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SizedBox(height: height, width: width),
      ),
    );
  }
}
