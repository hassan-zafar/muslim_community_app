import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windsor_essex_muslim_care/screens/homePage.dart';

import '../../commonUIFunctions.dart';
import '../../constants.dart';
import 'emailSignUp.dart';

class SignUpOptions extends StatefulWidget {
  @override
  _SignUpOptionsState createState() => _SignUpOptionsState();
}

class _SignUpOptionsState extends State<SignUpOptions> {
  // TapGestureRecognizer _gestureRecognizer=TapGestureRecognizer()..onTap=(){
  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>LogIn));
  // }
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecoration(),
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Hero(
                    tag: "logo",
                    child: Image.asset(
                      logo,
                      height: 120,
                    )),
                SizedBox(
                  height: 30,
                ),

                GestureDetector(
                  // onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => EmailSignUp(
                  //               isSocial: true,
                  //               isEdit: false,
                  //             ))),
                  onTap: () => Get.to(() => HomePage()),
                  child: buildSignUpLoginButton(
                      context: context,
                      btnText: "Continue With Google",
                      assetImage: googleLogo,
                      hasIcon: true),
                ),

//Other Options Text only
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Other Options",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailSignUp(
                                isSocial: false,
                                isEdit: false,
                              ))),
                  child: buildSignUpLoginButton(
                      context: context,
                      btnText: "Sign Up with Email",
                      assetImage: emailIcon,
                      hasIcon: true,
                      textColor: Colors.white,
                      color: Colors.green),
                ),

                SizedBox(
                  height: 10,
                ),
// Move to Log In Page
              ],
            ),
          ),
          bottomSheet: buildSignUpLoginText(
              context: context,
              text1: "Already have an account? ",
              text2: "Log In",
              moveToLogIn: true),
        ),
      ),
    );
  }
}
