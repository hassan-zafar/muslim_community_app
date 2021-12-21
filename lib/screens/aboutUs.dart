import 'package:flutter/material.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      decoration: backgroundColorBoxDecoration(),
      child: WebView(
        initialUrl: "https://wemuslimcare.ca/about-us",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    ));
  }
}
