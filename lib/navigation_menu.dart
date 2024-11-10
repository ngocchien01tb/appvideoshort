import 'dart:developer';

import 'package:appvideoshort/AddVideo/add_video_screen.dart';
import 'package:appvideoshort/Common/color.dart';
import 'package:appvideoshort/Controller/select_button_nav_index.dart';
import 'package:appvideoshort/Model/nav_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Home/home_screen.dart';
import 'User/profile_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  final screen = [
    const HomeScreen(),
    const AddVideoScreen(),
    const ProfileScreen(),
  ];
  NavigationMenuController navController = Get.put(NavigationMenuController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double widgetSize = screenWidth * 0.15;
    widgetSize = widgetSize.clamp(70.0, 100.0);
    log('widget: $widgetSize');
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SafeArea(
        bottom: false,
        // maintainBottomViewPadding: true,
        child: Container(
          height: widgetSize,
          color: kColorBackgroundDark,
          // padding: const EdgeInsets.only(left: 24, right: 24),
          // margin: const EdgeInsets.symmetric(horizontal: 24),
          child: LayoutBuilder(builder: (context, constraints) {
            double rowWidth = constraints.maxWidth;
            double itemWidth = rowWidth / bottonNavItems.length;
            log('rowWidth: $rowWidth');
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                bottonNavItems.length,
                (index) {
                  return InkWell(
                    onTap: () => navController.updateIndex(index),
                    child: Obx(() {
                      double sizeButton =
                          navController.selectedIndex.value == index ? 24 : 20;
                      Color colorButton =
                          navController.selectedIndex.value == index
                              ? kColorOrange
                              : kColorBackgroundLight;
                      return SizedBox(
                        width: itemWidth,
                        // height: widgetSize,
                        // width: double.,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              bottonNavItems[index].route,
                              width: sizeButton,
                              height: sizeButton,
                              color: colorButton,
                            ),
                            const SizedBox(height: 5),
                            Visibility(
                              visible:
                                  navController.selectedIndex.value == index,
                              child: Text(
                                bottonNavItems[index].title,
                                style:
                                    TextStyle(color: colorButton, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
            );
          }),
        ),
      ),
      body: Obx(() {
        return screen[navController.selectedIndex.value];
      }),
    );
  }
}
