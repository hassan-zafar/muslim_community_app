import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/screens/credentials/signUpRelated/emailSignUp.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  LiquidController liquidController;
  @override
  void initState() {
    super.initState();
    liquidController = LiquidController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColorBoxDecoration(),
      child: Scaffold(
        body: Stack(
          children: [
            LiquidSwipe(
              pages: pages,
              liquidController: liquidController,
            ),
            Positioned(
              bottom: 20,
              left: 40,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Get.off(() => EmailSignUp(isSocial: false, isEdit: false));
                  },
                  icon: Icon(Icons.skip_next_rounded),
                  label: Text("Skip")),
            ),
            Positioned(
              bottom: 20,
              right: 40,
              child: ElevatedButton.icon(
                  onPressed: () {
                    if (liquidController.currentPage < 9) {
                      liquidController.animateToPage(
                          page: liquidController.currentPage + 1);
                    } else {
                      Get.off(
                          () => EmailSignUp(isSocial: false, isEdit: false));
                    }
                  },
                  icon: Icon(Icons.next_plan_rounded),
                  label: Text("Next")),
            ),
          ],
        ),
      ),
    );

    // Container(
    //   decoration: backgroundColorBoxDecoration(),
    //   child: Scaffold(
    //     body: IntroductionScreen(
    //       pages: listPagesViewModel,
    //       color: Colors.white,
    //       onDone: () {
    //         Get.off(() => EmailSignUp(isSocial: false, isEdit: false));
    //       },
    //       onSkip: () {
    //         Get.off(() => EmailSignUp(isSocial: false, isEdit: false));
    //       },
    //       showSkipButton: true,
    //       skip: Row(
    //         children: [
    //           const Icon(Icons.skip_next),
    //           const Text(" Skip"),
    //         ],
    //       ),
    //       next: Row(
    //         children: [
    //           const Icon(Icons.next_plan_outlined),
    //           const Text(" Next"),
    //         ],
    //       ),
    //       done:
    //           const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
    //       dotsDecorator: DotsDecorator(
    //           size: const Size.square(3.0),
    //           activeSize: const Size(6.0, 3.0),
    //           activeColor: Theme.of(context).accentColor,
    //           color: Colors.black26,
    //           spacing: const EdgeInsets.symmetric(horizontal: 3.0),
    //           activeShape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(25.0))),
    //     ),
    //   ),
    // );
  }
}

final pages = [
  presentationImages("1"),
  presentationImages("2"),
  presentationImages("3"),
  presentationImages("4"),
  presentationImages("5"),
  presentationImages("6"),
  presentationImages("7"),
  presentationImages("8"),
  presentationImages("9"),
  presentationImages("10"),
];

Container presentationImages(String count) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/introPics/$count.png"),
      ),
    ),
  );
}

final listPagesViewModel = [
  PageViewModel(
    image: Image.asset(
      "assets/introPics/1.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "1",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/2.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "2",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/3.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "3",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/4.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "4",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/5.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "5",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/6.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "6",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/7.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "7",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/8.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "8",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/9.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "9",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/10.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "10",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/11.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "11",
  ),
  PageViewModel(
    image: Image.asset(
      "assets/introPics/12.png",
      fit: BoxFit.fitWidth,
    ),
    body: "",
    title: "12",
  ),
];
