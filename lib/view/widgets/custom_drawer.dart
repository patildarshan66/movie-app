import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_strings.dart';
import '../../utils/colors.dart';
import '../../utils/custom_dimensions.dart';
import '../../utils/custom_text_styles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: px_16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(px_60),
                ),
                margin: const EdgeInsets.symmetric(vertical: px_20),
                padding: const EdgeInsets.all(px_10),
                child: const Icon(Icons.person, size: px_100),
              ),
              Text(
                'Darshan Patil',
                style: h3_24ptBold(),
              ),
              const Divider(thickness: 2),
              ListTile(
                onTap: () {
                  Get.back();
                  Get.toNamed(RoutePath.searchHistoryRoute);
                },
                title: Text(
                  'Search History',
                  style: subTitle2_14ptMedium(),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,size: px_16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
