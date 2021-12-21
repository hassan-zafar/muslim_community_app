import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:windsor_essex_muslim_care/tools/neuomorphic.dart';

class LastJourney extends StatefulWidget {
  @override
  _LastJourneyState createState() => _LastJourneyState();
}

class _LastJourneyState extends State<LastJourney> {
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
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      top: -80,
                      child: LottieBuilder.asset(
                        windLottie,
                        width: MediaQuery.of(context).size.width,
                        // height: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Funeral and Burial",
                              style: titleTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          GlassContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Coordinators at Windsor mosque work with families and next of kin, to plan and to facilitate the transfer, storage, preparation, and burial of their deceased.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.8),
                              ),
                            ),
                          ),
                          GlassContainer(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Allah Says in the Holy Quran Chapter 32 Surah As-Sajdah verse 11:11 Say: 'The Angel of Death put in charge of you will (duely) take your souls (at the Decreed time and place): then shall ye be brought back to your Lord.'",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GlassContainer(
                  child: Column(
                    children: [
                      Text(
                        "Janazah Co-ordinators",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.8),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: contributers(
                            personName: "Naser (Abu Nabil) Ghamroui",
                            phoneNo: "(519) 563-9800",
                            telNo: "5195639800"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: contributers(
                            personName: "Walid Hamed",
                            phoneNo: "(519) 999-4424",
                            telNo: "5199994424"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: contributers(
                            personName: "Murad Aktas",
                            phoneNo: "(519) 562-0150",
                            telNo: "5195620150"),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cemeteryInfo(
                          imageName: countryMeadowsCemetery,
                          mosqueName: "Country Meadows Cemetery",
                          url: "https://www.countrymeadowscemetery.com/"),
                      cemeteryInfo(
                          imageName: windsorMemorials,
                          mosqueName: "Windsor Memorials",
                          url: "https://windsormemorial.com/"),
                    ],
                  ),
                ),
                cemeteryInfo(
                    imageName: alhijraLogo,
                    mosqueName: "Al-Hijra Islamic Gardens",
                    noUrl: true,
                    url: "http://alhijramosque.com/contact-us/"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  openImage() {
    Navigator.of(context).push(new PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return Material(
            elevation: 20,
            color: Colors.black87,
            child: Container(
              padding: EdgeInsets.all(20.0),
              height: double.maxFinite,
              width: 400.0,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Image.asset(alhijraImg),
                ),
              ),
            ),
          );
        }));
  }

  Row contributers({
    String personName,
    String phoneNo,
    String telNo,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$personName: "),
        InkWell(
          onTap: () => launch("tel://$telNo"),
          child: Text(
            " $phoneNo",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                wordSpacing: 2),
          ),
        ),
      ],
    );
  }

  Widget cemeteryInfo(
      {String imageName, String mosqueName, String url, bool noUrl = false}) {
    return InkWell(
      onTap: () {
        noUrl ? openImage() : launchURL(url);
      },
      child: EditedNeuomprphicContainer(
        icon: imageName,
        isImage: true,
        text: mosqueName,
      ),
    );
  }
}
