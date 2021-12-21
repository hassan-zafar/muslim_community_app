import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/tools/neuomorphic.dart';

class HifzProgram extends StatefulWidget {
  @override
  _HifzProgramState createState() => _HifzProgramState();
}

class _HifzProgramState extends State<HifzProgram> {
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
              children: [
                // LottieBuilder.asset(
                //   reciteKoranLottie,
                //   repeat: true,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Image.asset(
                  logo,
                  height: 200,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    hifzPrograms(
                        image: alnoorLogo,
                        programName: "An-Noor Private School",
                        url: "http://www.annoorschool.ca/islamic-atmosphere/"),
                    hifzPrograms(
                        image: alhijraLogo,
                        programName: "Al Hijra Academy",
                        url:
                            "http://alhijraacademy.com/academics/quran-program/"),
                  ],
                ),
                hifzPrograms(
                    image: chathamLogo,
                    programName: "Chatham Islamic Centre",
                    url: "https://www.thecic.ca/"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget hifzPrograms({
    String programName,
    String url,
    String image,
  }) =>
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            launchURL(url);
          },
          child: EditedNeuomprphicContainer(
            isImage: true,
            icon: image,
            text: programName,
          ),
        ),
      );
}
