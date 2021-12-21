import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:neuomorphic_container/neuomorphic_container.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:windsor_essex_muslim_care/screens/mosquesList.dart';

class PrayersTimings extends StatefulWidget {
  @override
  _PrayersTimingsState createState() => _PrayersTimingsState();
}

class _PrayersTimingsState extends State<PrayersTimings> {
  void _incrementCounter() {
    setState(() {});
  }

  void launchURL(_url) async => await canLaunch(_url)
      ? await launch(
          _url,
        )
      : throw 'Could not launch $_url';
  final _url = 'http://www.windsorislamicassociation.com/';

  final location = new Location();
  String locationError;
  PrayerTimes prayerTimes;

  @override
  void initState() {
    getLocationData().then((locationData) {
      if (!mounted) {
        return;
      }
      if (locationData != null) {
        setState(() {
          prayerTimes = PrayerTimes(
              Coordinates(locationData.latitude, locationData.longitude),
              DateComponents.from(DateTime.now()),
              CalculationMethod.north_america.getParameters());
        });
      } else {
        setState(() {
          locationError = "Couldn't Get Your Location!";
        });
      }
    });

    super.initState();
  }

  Future<LocationData> getLocationData() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Builder(
              builder: (BuildContext context) {
                if (prayerTimes != null) {
                  return Column(
                    children: [
                      Image.asset(
                        prayerPagePicture,
                        fit: BoxFit.fitWidth,
                        colorBlendMode: BlendMode.srcOver,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Prayer Timings for Today',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          prayerTimingsContainer(
                              prayTime: prayerTimes.fajr,
                              prayerName: "Fajr Time"),
                          prayerTimingsContainer(
                              prayTime: prayerTimes.sunrise,
                              prayerName: "Sunrise Time"),
                          prayerTimingsContainer(
                              prayTime: prayerTimes.dhuhr,
                              prayerName: "Dhuhr Time"),
                          prayerTimingsContainer(
                              prayTime: prayerTimes.asr,
                              prayerName: "Asr Time"),
                          prayerTimingsContainer(
                              prayTime: prayerTimes.maghrib,
                              prayerName: "Maghrib Time"),
                          prayerTimingsContainer(
                              prayTime: prayerTimes.isha,
                              prayerName: "Isha Time"),
                          OpenContainer(
                            //closedColor: Colors.transparent,
                            //closedElevation: 0,
                            closedBuilder:
                                (BuildContext context, void Function() action) {
                              return NeuomorphicContainer(
                                color: containerColor,
                                style: NeuomorphicStyle.Convex,
                                width: 200,
                                intensity: 0.6,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Hero(
                                        tag: "mosqueIcon",
                                        child: Lottie.asset(mosqueGumbatLottie,
                                            height: 80),
                                      ),
                                      Hero(
                                          tag: "mosque_timings",
                                          child: Text(
                                              "Local Mosque's\nPrayer Timings")),
                                    ],
                                  ),
                                ),
                              );
                            },
                            openBuilder: (BuildContext context,
                                void Function({Object returnValue}) action) {
                              return MosquesPrayerTimings();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }
                if (locationError != null) {
                  return Text(locationError);
                }
                return Center(child: Text('Waiting for Your Location...'));
              },
            ),
          ),
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  Widget prayerTimingsContainer({String prayerName, DateTime prayTime}) {
    var asd = prayerTimes.nextPrayerByDateTime(prayTime);
    bool isNext = false;
    var nextPrayer = prayerTimes.nextPrayerByDateTime(DateTime.now());
    if (asd == nextPrayer) isNext = true;
    return Container(
      color: isNext ? Color(0xff467D89) : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$prayerName ',
                  style: TextStyle(
                    fontSize: 24,
                    color: isNext ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  DateFormat.jm().format(prayTime),
                  style: TextStyle(
                    fontSize: 24,
                    color: isNext ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
