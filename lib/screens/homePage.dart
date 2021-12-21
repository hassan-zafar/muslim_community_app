import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:windsor_essex_muslim_care/screens/allBusinessPage.dart';
import 'package:windsor_essex_muslim_care/screens/islamicSchools.dart';
import 'package:windsor_essex_muslim_care/screens/prayerTimings.dart';
import 'package:windsor_essex_muslim_care/screens/qiblaPage.dart';

import '../constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int pageIndex = 0;

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(
      pageIndex,
    );
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecoration(),
        child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                controller: pageController,
                onPageChanged: onPageChanged,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  AllBusinessesPage(),
                  IslamicSchools(),
                  QiblahCompass(),
                  PrayersTimings()
                ],
              ),
            ],
          ),
          bottomNavigationBar: GlassContainer(
            opacity: 0.2,
            blur: 8,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: BottomNavigationBar(
              backgroundColor: Color(0x00ffffff),
              currentIndex: pageIndex,
              onTap: onTap,
              elevation: 0,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket_outlined),
                  label: "businesses",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.ac_unit), label: "qibla Directions"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.ac_unit), label: "Islamic Schools"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_pharmacy_rounded),
                    label: "Prayer Timings")
              ],
            ),
          ),
// Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Icon(
//                         Icons.shopping_basket_outlined,
//                         size: 35,
//                       ),
//                       Icon(
//                         Icons.assistant_navigation,
//                         size: 35,
//                       )
//                     ],
//                   ),

          // bottomNavigationBar: GlassContainer(
          //   opacity: 1,
          //   blur: 8,
          //   child: FloatingNavBar(
          //     color: Colors.white10,
          //     selectedIconColor: Colors.white,
          //     unselectedIconColor: Colors.white.withOpacity(0.6),
          //     items: [
          //       FloatingNavBarItem(
          //           iconData: Icons.home_outlined,
          //           page: AllBusinessesPage(),
          //           title: 'Home'),
          //       FloatingNavBarItem(
          //           iconData: Icons.home_outlined,
          //           page: QiblaPage(),
          //           title: 'Home'),
          //     ],
          //     horizontalPadding: 10.0,
          //     hapticFeedback: true,
          //     showTitle: true,
          //   ),
          // ),
        ),
      ),
    );
  }
}
