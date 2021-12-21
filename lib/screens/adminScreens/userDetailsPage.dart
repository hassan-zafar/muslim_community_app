import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lottie/lottie.dart';
import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/models/bankDetailsModel.dart';
import 'package:windsor_essex_muslim_care/models/userModel.dart';

class UserDetailsPage extends StatefulWidget {
  final UserModel userDetails;
  UserDetailsPage({@required this.userDetails});
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  BankDetailsModel bankInfo;
  List dependents = [];
  @override
  Widget build(BuildContext context) {
    dependents = widget.userDetails.dependents;
    return Container(
      decoration: backgroundColorBoxDecorationLogo(),
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            Lottie.asset(userDetailsLottie, height: 150, repeat: false),
            wrappingContainer(buildUserDetails()),
            wrappingContainer(buildemergency()),
            wrappingContainer(buildDependents()),
            wrappingContainer(buildBankInfo()),
          ],
        ),
      ),
    );
  }

  Padding wrappingContainer(Widget buildWidget) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassContainer(
        opacity: 0.4,
        child: buildWidget,
      ),
    );
  }

  Widget buildBankInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: bankInfoRef.doc(widget.userDetails.userId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("BANK INFO LOADING");
          }
          bankInfo = BankDetailsModel.fromDocument(snapshot.data);
          return Column(
            children: [
              Text(
                "Bank Info",
                style: titleTextStyle(),
              ),
              Divider(
                thickness: 1,
              ),
              rowText(fieldName: "Email", result: bankInfo.email),
              SizedBox(
                height: 8,
              ),
              rowText(fieldName: "Bank Name", result: bankInfo.bankName),
              SizedBox(
                height: 8,
              ),
              rowText(fieldName: "Account No", result: bankInfo.accountNo),
              SizedBox(
                height: 8,
              ),
              rowText(fieldName: "Transit No", result: bankInfo.transitNo),
              SizedBox(
                height: 8,
              ),
              rowText(fieldName: "Reference No", result: bankInfo.referenceNo),
              SizedBox(
                height: 8,
              ),
            ],
          );
        },
      ),
    );
  }

  Row rowText({final String fieldName, final String result}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            fieldName,
            style: customTextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: Text(
            result,
            style: customTextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget buildemergency() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Emergency Info',
            style: titleTextStyle(fontSize: 25),
          ),
          Divider(
            thickness: 1,
          ),
          rowText(
              fieldName: "Contact Name",
              result: widget.userDetails.emergencyName),
          SizedBox(
            height: 8.0,
          ),
          rowText(
              fieldName: "Contact Number",
              result: widget.userDetails.emergencyPhoneNo),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }

  Widget buildDependents() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Dependent's Info",
            style: titleTextStyle(fontSize: 25),
          ),
          Divider(
            thickness: 1,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dependents.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(
                      "$index",
                      style: titleTextStyle(),
                    ),
                    rowText(
                        fieldName: "First Name",
                        result: dependents[index]["firstName"]),
                    SizedBox(
                      height: 8.0,
                    ),
                    rowText(
                        fieldName: "Last Name",
                        result: dependents[index]["lastName"]),
                    SizedBox(
                      height: 8.0,
                    ),
                    rowText(
                        fieldName: "Relationship",
                        result: dependents[index]["relationship"]),
                    SizedBox(
                      height: 8.0,
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }

  Widget buildUserDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Details',
            style: titleTextStyle(fontSize: 25),
          ),
          Divider(
            thickness: 1,
          ),
          rowText(
              fieldName: "Is Admin",
              result: widget.userDetails.isAdmin ? "YES" : "NO"),
          SizedBox(
            height: 8.0,
          ),
          rowText(
              fieldName: "Name",
              result:
                  "${widget.userDetails.firstName} ${widget.userDetails.middleName} ${widget.userDetails.lastName}"),
          SizedBox(
            height: 8.0,
          ),
          rowText(fieldName: "Email", result: widget.userDetails.email),
          SizedBox(
            height: 8.0,
          ),
          rowText(fieldName: "City", result: widget.userDetails.city),
          SizedBox(
            height: 8.0,
          ),
          rowText(fieldName: "Cell No", result: widget.userDetails.cellNo),
          SizedBox(
            height: 8.0,
          ),
          rowText(fieldName: "Phone No", result: widget.userDetails.phoneNo),
          SizedBox(
            height: 8.0,
          ),
          rowText(
              fieldName: "Home Phone No",
              result: widget.userDetails.homePhoneNo),
          SizedBox(
            height: 8.0,
          ),
          rowText(
              fieldName: "Has Will Prepared",
              result: widget.userDetails.hasWillPrepared ? "YES" : "NO"),
          SizedBox(
            height: 8.0,
          ),
          rowText(
              fieldName: "Immigration Type",
              result: widget.userDetails.immigrationStatus),
          SizedBox(
            height: 8.0,
          ),
          rowText(
              fieldName: "Is Canadian Citizen ",
              result: widget.userDetails.isCanadianCitizen ? "YES" : "NO"),
          SizedBox(
            height: 8.0,
          ),
          rowText(
              fieldName: "Next To Kin Name ",
              result: widget.userDetails.nextToKinName),
          SizedBox(
            height: 8.0,
          ),
        ],
      ),
    );
  }
}
