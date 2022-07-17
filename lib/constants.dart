import 'package:flutter/material.dart';

String announcementsIcon = "assets/images/loudspeaker.svg";
String logo = "assets/images/logo.png";
String logoBackground = "assets/images/logoBackground.jpeg";
String countryMeadowsCemetery = "assets/images/countryMeadowsCemetery.png";
String windLottie = "assets/lottie/weather-wind.json";
String communityIcon = "assets/images/community.svg";
String windsorMemorials = "assets/images/windsorMemorials.png";
String kaaba = "assets/images/kaaba-building.svg";
String prayer = "assets/images/prayerTimings.png";
String mosqueBackGround = "assets/images/mosqueBackground.jpg";
String loginIcon = "assets/images/logIn.svg";
String signUp = "assets/images/signUp.svg";
String hifzProgram = "assets/images/hifzProgram.png";
String memberModule = "assets/images/member_module.png";
String lastJourney = "assets/images/corpse.svg";
String shop = "assets/images/business.png";
String googleLogo = "assets/images/google.png";
String facebookLogo = "assets/images/facebook.png";
String emailIcon = "assets/images/email.png";
String forgetPassPageIcon = "assets/images/MaskGroup1.png";
String plusIcon = "assets/images/plus.png";
String minusIcon = "assets/images/minus.png";
String deleteIcon = "assets/images/Icon_Delete.png";
String bagIcon = "assets/images/bag.png";
String locationIcon = "assets/images/location.png";
String bellIcon = "assets/images/bell.png";
String editProfileIcon = "assets/images/editProfile.png";
String notificationIcon = "assets/images/Notifications.png";
String logoutIcon = "assets/images/logOut.svg";
String aboutUsIcon = "assets/images/aboutUs.png";
String makeAdanLottie = "assets/lottie/make_adan.json";
String reciteKoranLottie = "assets/lottie/read_koran.json";
String staryCeilingLottie = "assets/lottie/stary_ceiling.json";
String mosqueGumbatLottie = "assets/lottie/mosque_gumbat.json";
String announcementsLottie = "assets/lottie/announcement.json";
String windsorLogo = "assets/images/windsorLogo.png";
String alhijraLogo = "assets/images/alhijraLogo.png";
String chathamLogo = "assets/images/chathamLogo.png";
String macLogo = "assets/images/macLogo.png";
String masjidNoorLogo = "assets/images/masjidNoorLogo.jpg";
String prayerPagePicture = "assets/images/prayerPagePicture.png";
String alnoorLogo = "assets/images/alnoorLogo.png";
String alhijraImg = "assets/images/alhijra_img.jpeg";
String userDetailsLottie = "assets/lottie/userDetails.json";
String searchUsersLottie = "assets/lottie/searchUsers.json";

TextStyle titleTextStyle({double fontSize = 25, Color color = Colors.black}) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: color,
      letterSpacing: 1.8);
}

TextStyle customTextStyle(
    {FontWeight fontWeight = FontWeight.w300,
    double fontSize = 25,
    Color color = Colors.black}) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 3);
}

Color containerColor = Color(0xff96B7BF);

// Colors.white;
//  Color(0xffFED5E3);
BoxDecoration backgroundColorBoxDecorationLogo() {
  return BoxDecoration(
    image: DecorationImage(
        image: AssetImage(logo),
        colorFilter: ColorFilter.mode(Colors.white70, BlendMode.srcATop),
        alignment: Alignment.center,
        scale: 0.3),
    gradient: LinearGradient(
      colors: [
        // Color(0xff387A53),
        // Color(0xff8BE78B),

        Colors.white,

        Color(0xff96B7BF),

        // Colors.green[100],
        // Colors.blue[200],
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    ),
  );
}

BoxDecoration backgroundColorBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        // Color(0xff387A53),
        // Color(0xff8BE78B),

        Colors.white,
        // Color(0xffFED5E3),
        Color(0xff96B7BF),

        // Colors.green[100],
        // Colors.blue[200],
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    ),
  );
}

BoxDecoration drawerColorBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [
        // Color(0xff8BE78B),
        Colors.black,
        Colors.green[100],
      ],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    ),
  );
}
