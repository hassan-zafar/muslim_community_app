import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/tools/neuomorphic.dart';

class MosquesPrayerTimings extends StatelessWidget {
  void launchURL(String _url) async => await canLaunch(_url)
      ? await launch(
          _url,
        )
      : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecoration(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: "mosqueIcon",
                      child: LottieBuilder.asset(
                        mosqueGumbatLottie,
                        height: 200,
                      ),
                    ),
                    Hero(
                      tag: "mosque_timings",
                      child: Text(
                        "Local Mosque's\nPrayer Timings",
                        style: titleTextStyle(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      mosqueInfo(
                          imageName: chathamLogo,
                          mosqueName: "Chatham Islamic Centre",
                          url: "https://www.thecic.ca/"),
                      mosqueInfo(
                          imageName: alhijraLogo,
                          mosqueName: "Al Hijra Mosque",
                          url: "http://alhijramosque.com/"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      mosqueInfo(
                          imageName: windsorLogo,
                          mosqueName: "Windsor Islamic Association",
                          url: "https://windsorislamicassociation.com/"),
                      mosqueInfo(
                          imageName: macLogo,
                          mosqueName: "Muslim Association of Canada",
                          url: "https://centres.macnet.ca/rcic/"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: mosqueInfo(
                      imageName: masjidNoorLogo,
                      mosqueName: "Masjid Noor-Ul-Islam",
                      url: "http://masjid-noor-ul-islam.edan.io/"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mosqueInfo({
    String imageName,
    String mosqueName,
    String url,
  }) {
    return InkWell(
      onTap: () {
        launchURL(url);
      },
      child: EditedNeuomprphicContainer(
        icon: imageName,
        isImage: true,
        text: mosqueName,
      ),
    );
  }
}
