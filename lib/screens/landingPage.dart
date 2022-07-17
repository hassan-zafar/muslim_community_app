import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:windsor_essex_muslim_care/Database/local_database.dart';
import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/main.dart';
import 'package:windsor_essex_muslim_care/models/userModel.dart';
import 'package:windsor_essex_muslim_care/screens/aboutUs.dart';
import 'package:windsor_essex_muslim_care/screens/adminScreens/allUsers.dart';
import 'package:windsor_essex_muslim_care/screens/announcements/announcements.dart';
import 'package:windsor_essex_muslim_care/screens/communityServicesPages/allCommunityServices.dart';
import 'package:windsor_essex_muslim_care/screens/credentials/loginRelated/login.dart';
import 'package:windsor_essex_muslim_care/screens/hifzProgram.dart';
import 'package:windsor_essex_muslim_care/screens/lastJourney.dart';
import 'package:windsor_essex_muslim_care/screens/prayerTimings.dart';
import 'package:windsor_essex_muslim_care/screens/qiblaPage.dart';
import 'package:windsor_essex_muslim_care/services/authentication_service.dart';
import 'package:windsor_essex_muslim_care/tools/loading.dart';
import 'package:windsor_essex_muslim_care/tools/neuomorphic.dart';

import 'businessPages/allBusinessPage.dart';

String userUid;
String email;
String token;
List<UserModel> allUsersList = [];

bool isAdmin = false;
void showNotification() {
  flutterLocalNotificationsPlugin.show(
      0,
      "Testing ",
      "How you doin ?",
      NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              importance: Importance.high,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher')));
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isLoading = false;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging;
  getAllUsers() async {
    setState(() {
      _isLoading = true;
    });
    QuerySnapshot snapshots = await userRef.get();
    snapshots.docs.forEach((e) {
      allUsersList.add(UserModel.fromDocument(e));
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (isAdmin) {
      getAllUsers();
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String asd = UserLocalData().getUserUIDGet();
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),

                      InkWell(
                        onLongPress: () =>
                            isAdmin ? Get.to(() => UserNSearch()) : null,
                        child: Hero(
                            tag: "logo",
                            child: Image.asset(
                              logo,
                              height: 200,
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => Announcements()),
                            child: EditedNeuomprphicContainer(
                              icon: announcementsIcon,
                              text: "WEMC Updates",
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => AboutUsPage()),
                            child: EditedNeuomprphicContainer(
                              icon: aboutUsIcon,
                              isImage: true,
                              text: "About Us",
                              isLanding: true,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => LastJourney()),
                            child: EditedNeuomprphicContainer(
                              icon: lastJourney,
                              text: "Last Journey",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => userUid != ""
                                  ? LoginPage()
                                  : AllBusinessesPage());
                            },
                            child: EditedNeuomprphicContainer(
                              icon: shop,
                              text: "Businesses",
                              isLanding: true,
                              isImage: true,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() => userUid != ""
                                ? LoginPage()
                                : AllCommunityServicesPage()),
                            child: EditedNeuomprphicContainer(
                              icon: communityIcon,
                              text: "Community Services",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => QiblahCompass());
                            },
                            child: EditedNeuomprphicContainer(
                              icon: kaaba,
                              text: "Kaaba Directions",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() => PrayersTimings()),
                            child: EditedNeuomprphicContainer(
                              icon: prayer,
                              text: "Prayer Timings",
                              isImage: true,
                              isLanding: true,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() =>
                                userUid == "" ? LoginPage() : HifzProgram()),
                            child: EditedNeuomprphicContainer(
                              icon: userUid == null && userUid == ""
                                  ? memberModule
                                  : hifzProgram,
                              text: userUid == null && userUid == ""
                                  ? "Become a Member"
                                  : "Hifz Program",
                              isImage: true,
                              isLanding: true,
                            ),
                          ),
                          userUid != null && userUid != ""
                              ? GestureDetector(
                                  onTap: () {
                                    AuthenticationService().signOut();
                                    UserLocalData().logOut();
                                    Get.off(() => LoginPage());
                                  },
                                  child: EditedNeuomprphicContainer(
                                    icon: logoutIcon,
                                    text: "Log Out",
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),

// Move to Log In Page
                    ],
                  ),
                ),
              ),
              _isLoading ? LoadingIndicator() : Container()
            ],
          ),
        ),
      ),
    );
  }
}
