import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import 'package:uuid/uuid.dart';
import 'package:windsor_essex_muslim_care/commonUIFunctions.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/models/userModel.dart';
import 'package:windsor_essex_muslim_care/screens/landingPage.dart';
import 'package:windsor_essex_muslim_care/services/authentication_service.dart';
import 'package:windsor_essex_muslim_care/tools/custom_toast.dart';
import 'package:windsor_essex_muslim_care/tools/loading.dart';
import 'package:windsor_essex_muslim_care/tools/policy.dart';

class EmailSignUp extends StatefulWidget {
  final bool isSocial;
  final bool isEdit;
  EmailSignUp({@required this.isSocial, @required this.isEdit});
  @override
  _EmailSignUpState createState() => _EmailSignUpState();
}

class _EmailSignUpState extends State<EmailSignUp> {
  final _textFormKey = GlobalKey<FormState>();
  final FixedExtentScrollController immigrationController =
      FixedExtentScrollController(initialItem: 0);
  final FixedExtentScrollController yesNoController1 =
      FixedExtentScrollController(initialItem: 0);
  final FixedExtentScrollController yesNoController2 =
      FixedExtentScrollController(initialItem: 0);

//naming Info
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _nextToKinNameController = TextEditingController();
//city info
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _cityNameController = TextEditingController();

//Phone Numbers
  TextEditingController _homePhoneNoController = TextEditingController();
  TextEditingController _cellNoController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
//emergency
  TextEditingController _emergencyPhoneNoController = TextEditingController();
  TextEditingController _emergencyNameController = TextEditingController();

//bank Info
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _bankAccountNoController = TextEditingController();
  TextEditingController _bankTransitNoController = TextEditingController();
  TextEditingController _bankReferenceNoController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();

//dependent's info
  TextEditingController _dependentFirstNameController = TextEditingController();
  TextEditingController _dependentRelationNameController =
      TextEditingController();
  TextEditingController _dependentLastNameController = TextEditingController();
  List<Map<String, String>> dependents = [];
  bool _obscureText = true;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText2 = true;
  TextEditingController _confirmPasswordController = TextEditingController();
  String registerId = Uuid().v4();
  String socialId = Uuid().v4();
  Position position;

  bool _isComplete = false;
  bool isCanadianCitizen = false;

  bool _isLoading = false;

  String immigrationStatus = "Permanent Resident";

  bool workAsVolunteer = false;

  bool hasWillPrepared = false;

  // getUserEditInfo() {
  //   _firstNameController.text = currentUser.fname;
  //   _emailController.text = currentUser.email;
  //   _addressController.text = currentUser.location;
  //   _phoneNoController.text = currentUser.contact;
  //   _passwordController.text = currentUser.password;
  // }

  @override
  void initState() {
    super.initState();
    // widget.isEdit ? getUserEditInfo() : null;
  }

  int _currentStep = 0;
  continued() {
    _currentStep < 3 ? setState(() => _currentStep += 1) : null;
    _currentStep == 3 ? setState(() => _isComplete = true) : null;
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecorationLogo(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
            key: _textFormKey,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Hero(
                          tag: "logo",
                          child: Image.asset(
                            logo,
                            height: 150,
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Stepper(
                        physics: BouncingScrollPhysics(),
                        type: StepperType.vertical,
                        currentStep: _currentStep,
                        onStepCancel: cancel,
                        onStepTapped: tapped,
                        controlsBuilder: (BuildContext context, _) {
                          return _isComplete
                              ? GestureDetector(
                                  onTap: () {
                                    _handleSignUp(context);
                                  },
                                  child: buildSignUpLoginButton(
                                    context: context,
                                    btnText: "Sign Up",
                                    hasIcon: false,
                                    color: Color(0xff387A53),
                                    textColor: Colors.black,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: continued,
                                      child: Text(
                                        'NEXT',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: cancel,
                                      child: const Text(
                                        'CANCEL',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                );
                        },
                        steps: [
                          Step(
                            title: Text("Account"),
                            isActive: _currentStep >= 0,
                            content: Padding(
                              padding: EdgeInsets.all(12),
                              child: Center(
                                child: Column(
                                  children: [
                                    title(title: "Account Details"),
//Name
                                    TextInputCard(
                                      controller: _firstNameController,
                                      label: "First Name",
                                      hintText: "Please Enter Your First Name",
                                      validatorErrorText: "Name Too Short",
                                      validationStringLength: 3,
                                    ),
//Middle Name
                                    TextInputCard(
                                      controller: _middleNameController,
                                      label: "Middle Name",
                                      hintText: "Please Enter Your Middle Name",
                                      validatorErrorText: "Name Too Short",
                                      validationStringLength: 3,
                                    ),
//Last Name
                                    TextInputCard(
                                      controller: _lastNameController,
                                      label: "Last Name",
                                      hintText: "Please Enter Your Last Name",
                                      validatorErrorText: "Name Too Short",
                                      validationStringLength: 3,
                                    ),
//Email
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: TextFormField(
                                            controller: _emailController,
                                            keyboardType: TextInputType.text,
                                            validator: (val) {
                                              if (val == null) {
                                                return null;
                                              }
                                              if (val.isEmpty) {
                                                return "Field is Empty";
                                              } else if (!val.contains("@") ||
                                                  val.trim().length < 7) {
                                                return "Invalid Email Address!";
                                              } else {
                                                return null;
                                              }
                                            },
                                            // onSaved: (val) => phoneNo = val,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelText: "Email Address",
                                              //filled: true,
                                              labelStyle:
                                                  TextStyle(fontSize: 15.0),
                                              hintText:
                                                  "Please enter your valid E-mail address",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

//Phone Number
                                    TextInputCard(
                                      controller: _phoneNoController,
                                      label: "Contact Number",
                                      hintText:
                                          "Please Enter Your Phone Number",
                                      validatorErrorText: "Number Too Short",
                                      validationStringLength: 7,
                                    ),
//Cell Number
                                    TextInputCard(
                                      controller: _cellNoController,
                                      label: "Cell Phone",
                                      hintText: "Please Enter Your Cell Number",
                                      validatorErrorText: "Number Too Short",
                                      validationStringLength: 7,
                                    ),
//Home Number
                                    TextInputCard(
                                      controller: _homePhoneNoController,
                                      label: "Home Phone",
                                      hintText:
                                          "Please Enter Your Home Phone Number",
                                      validatorErrorText: "Number Too Short",
                                      validationStringLength: 7,
                                    ),
//Next To Kin Name
                                    TextInputCard(
                                      controller: _nextToKinNameController,
                                      label: "Next To Kin Name",
                                      hintText: "Next To Kin Name",
                                      validatorErrorText: "Name Too Short",
                                      validationStringLength: 3,
                                    ),
//Emergency One
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        
                                        // shape: RoundedRectangleBorder(
                                        //     borderRadius:
                                        //         BorderRadius.all(Radius.circular(8))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text("Emergency Contact Person"),
//Emergency Contact Number

                                              TextInputCard(
                                                controller:
                                                    _emergencyNameController,
                                                label: "Person's Name",
                                                hintText:
                                                    "Enter person's name to be contacted in emergency",
                                                validatorErrorText:
                                                    "Name Too Short",
                                                validationStringLength: 3,
                                              ),
//Emergengy Contact phone No
                                              TextInputCard(
                                                controller:
                                                    _emergencyPhoneNoController,
                                                label: "Phone Number",
                                                hintText:
                                                    "Please Enter Your Middle Name",
                                                validatorErrorText:
                                                    "Phone Number Too Short",
                                                validationStringLength: 7,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

//Password
                                    widget.isSocial
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: TextFormField(
                                                  obscureText: _obscureText,
                                                  validator: (val) =>
                                                      val != null &&
                                                              val.length < 6
                                                          ? 'Password Too Short'
                                                          : null,
                                                  controller:
                                                      _passwordController,
                                                  decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _obscureText =
                                                              !_obscureText;
                                                        });
                                                      },
                                                      child: Icon(_obscureText
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off),
                                                    ),
                                                    border: InputBorder.none,
                                                    labelText: "Password",
                                                    hintText:
                                                        "Enter a valid password, min length 6",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

//Confirm Password
                                    widget.isSocial
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0, right: 8.0),
                                                child: TextFormField(
                                                  obscureText: _obscureText2,
                                                  validator: (val) =>
                                                      val != null &&
                                                              val.length < 6
                                                          ? 'Password Too Short'
                                                          : null,
                                                  controller:
                                                      _confirmPasswordController,
                                                  decoration: InputDecoration(
                                                    suffixIcon: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _obscureText2 =
                                                              !_obscureText2;
                                                        });
                                                      },
                                                      child: Icon(_obscureText
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off),
                                                    ),
                                                    border: InputBorder.none,
                                                    labelText:
                                                        "Confirm Password",
                                                    hintText:
                                                        "Re-Enter Password",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

//City Name
                                    TextInputCard(
                                      controller: _cityNameController,
                                      label: "City Name",
                                      hintText: "Please Enter Your City's Name",
                                      validatorErrorText: "Name Too Short",
                                      validationStringLength: 3,
                                    ),
                                    //Postal Code
                                    TextInputCard(
                                      controller: _postalCodeController,
                                      label: "Postal Code",
                                      hintText:
                                          "Please Enter Your Are's Postal Code",
                                      validatorErrorText:
                                          "Postal Code Too Short",
                                      validationStringLength: 3,
                                    ),

//location
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: TextFormField(
                                            controller: _addressController,
                                            decoration: InputDecoration(
                                              hintText: "Enter Your address",
                                              labelText: "Enter Your address",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 200.0,
                                      height: 100.0,
                                      alignment: Alignment.center,
                                      child: RaisedButton.icon(
                                        label: Text(
                                          "Use Current Location",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                        color: Color(0xff387A53),
                                        onPressed: getUserLocation,
                                        icon: Icon(
                                          Icons.my_location,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Step(
                              title: Text("Immigration"),
                              isActive: _currentStep >= 1,
                              content: Column(
                                children: [
                                  //Immigration Status
                                  title(title: "Immigration"),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                          "Immigration Status")),
                                                  Expanded(
                                                      flex: 2,
                                                      child: yesNoPicker(
                                                          controller:
                                                              immigrationController,
                                                          isImmigration: true)),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Checkbox(
                                                  onChanged: (bool val) {
                                                    setState(() {
                                                      isCanadianCitizen = val;
                                                    });
                                                  },
                                                  checkColor: Colors.white,
                                                  activeColor: Colors.black,
                                                  value: isCanadianCitizen,
                                                ),
                                                Text("Canadian Citizen"),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
//Questions
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      "Are You willing to work as volunteer"),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: yesNoPicker(
                                                        controller:
                                                            yesNoController1,
                                                        isVolunteer: true)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      "Have you had your will prepared"),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: yesNoPicker(
                                                        controller:
                                                            yesNoController2,
                                                        isVolunteer: false)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Step(
                              isActive: _currentStep >= 2,
                              title: Text("Dependents"),
                              content: Column(
                                children: [
                                  title(title: "Dependents"),
                                  TextInputCard(
                                      controller: _dependentFirstNameController,
                                      label: "Dependent's First Name",
                                      validatorErrorText:
                                          "Please enter correct name",
                                      validationStringLength: 3,
                                      hintText:
                                          "Enter Your Dependent's First Name"),
                                  TextInputCard(
                                      controller: _dependentLastNameController,
                                      label: "Dependent's Last Name",
                                      validatorErrorText:
                                          "Please enter correct name",
                                      validationStringLength: 3,
                                      hintText:
                                          "Enter Your Dependent's Last Name"),
                                  TextInputCard(
                                      controller:
                                          _dependentRelationNameController,
                                      label: "Relationship to applicants",
                                      validatorErrorText:
                                          "Please enter correct name",
                                      validationStringLength: 3,
                                      hintText:
                                          "Enter your relationship to principle applicant"),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Map<String, String> dependent = {
                                        "firstName":
                                            _dependentFirstNameController.text,
                                        "lastName":
                                            _dependentLastNameController.text,
                                        "relationship":
                                            _dependentRelationNameController
                                                .text,
                                      };
                                      setState(() {
                                        dependents.add(dependent);
                                        _dependentFirstNameController.clear();
                                        _dependentLastNameController.clear();
                                        _dependentRelationNameController
                                            .clear();
                                      });
                                    },
                                    icon: Icon(Icons.add),
                                    label: Text("Add another dependent"),
                                  ),
                                ],
                              )),
                          Step(
                              title: Text("Banking"),
                              isActive: _currentStep >= 3,
                              content: Column(
                                children: [
                                  title(title: "Banking Details"),
                                  Text(
                                    'Please provide banking details below for auto deduction of funeral contributions:',
                                    textAlign: TextAlign.center,
                                  ),
                                  TextInputCard(
                                    controller: _bankNameController,
                                    label: "Bank Name",
                                    hintText: "Please Enter Your Bank Name",
                                    validatorErrorText: "Number Too Short",
                                    validationStringLength: 5,
                                  ),
                                  TextInputCard(
                                    controller: _bankAccountNoController,
                                    label: "Account Number",
                                    hintText:
                                        "Please Enter Your Bank Account Number,7 digits",
                                    validatorErrorText: "Number Too Short",
                                    validationStringLength: 7,
                                  ),
                                  TextInputCard(
                                    controller: _bankReferenceNoController,
                                    label: "Institution Number",
                                    hintText:
                                        "Please Enter Your Institution Number,3 digits",
                                    validatorErrorText: "Number Too Short",
                                    validationStringLength: 3,
                                  ),
                                  TextInputCard(
                                    controller: _bankTransitNoController,
                                    label: "Transit Number",
                                    hintText:
                                        "Please Enter Your Bank Transition Number, 5 digits",
                                    validatorErrorText: "Number Too Short",
                                    validationStringLength: 3,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    buildSignUpLoginText(
                        context: context,
                        text1: "Already have an account?",
                        text2: "LogIn",
                        moveToLogIn: true),
                    _isLoading ? LoadingIndicator() : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column title({String title}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }

  Container yesNoPicker({
    final controller,
    bool isImmigration: false,
    bool isVolunteer: true,
  }) {
    return Container(
      // width: 100,
      height: isImmigration ? 100 : 60,
      child: CupertinoPicker(
        selectionOverlay: null,
        // squeeze: 1.5,
        onSelectedItemChanged: (int value) {
          if (isImmigration) {
            if (value == 0) {
              immigrationStatus = "Permanent Resident";
            } else if (value == 1) {
              immigrationStatus = "Student";
            } else {
              immigrationStatus = "Others";
            }
          } else if (isVolunteer) {
            if (value == 0) {
              workAsVolunteer = true;
            } else {
              workAsVolunteer = false;
            }
          } else {
            if (value == 0) {
              hasWillPrepared = true;
            } else {
              hasWillPrepared = false;
            }
          }
        },
        itemExtent: 23,
        scrollController: controller,
        children: isImmigration
            ? [
                Text(
                  "Permanent Resident",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Student",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Other",
                  style: TextStyle(fontSize: 18),
                )
              ]
            : [
                Text(
                  "YES",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "NO",
                  style: TextStyle(fontSize: 18),
                )
              ],
        useMagnifier: true,
        magnification: 1.3,
      ),
    );
  }

  void _handleSignUp(BuildContext context) async {
    final _form = _textFormKey.currentState;
    if (_form == null) {
      return null;
    }
    if (_form.validate()) {
      showDialog(
        context: context,
        builder: (context) => PolicyDialog(mdFileName: "policy.md"),
      ).then((value) async {
        setState(() {
          _isLoading = true;
        });
        UserModel userModel = UserModel();
        if (_dependentFirstNameController.text.isNotEmpty) {
          Map<String, String> _dependent = {
            "firstName": _dependentFirstNameController.text,
            "lastName": _dependentLastNameController.text,
            "relationship": _dependentRelationNameController.text,
          };
          dependents.add(_dependent);
        }
        User _user = await AuthenticationService()
            .signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          firstName: _firstNameController.text,
          middleName: _middleNameController.text,
          lastName: _lastNameController.text,
          displayName:
              "${_firstNameController.text} ${_lastNameController.text}",
          cellNo: _cellNoController.text,
          city: _cityNameController.text,
          emergencyName: _emergencyNameController.text,
          emergencyPhoneNo: _emergencyNameController.text,
          hasWillPrepared: hasWillPrepared,
          homePhoneNo: _homePhoneNoController.text,
          immigrationStatus: immigrationStatus,
          isCanadianCitizen: isCanadianCitizen,
          nextToKinName: _nextToKinNameController.text,
          dependents: dependents,
          phoneNo: _phoneNoController.text,
          postalCode: _postalCodeController.text,
          workAsVolunteer: workAsVolunteer,
          timestamp: DateTime.now().toString(),
          accountNo: _bankAccountNoController.text,
          bankName: _bankNameController.text,
          referenceNo: _bankReferenceNoController.text,
          transitNo: _bankTransitNoController.text,
        )
            .onError((error, stackTrace) {
          setState(() {
            _isLoading = false;
          });
          return null;
        });
        Navigator.of(context).pop();
        if (_user != null) {
          successToast(message: 'Successfully Registered');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => LandingPage())));
        }
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  getUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      position = _position;
    });
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placeMarks[0];
    String completeAddress =
        '${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, ${placemark.country}';
    _addressController.text = completeAddress;
  }
}

class TextInputCard extends StatelessWidget {
  const TextInputCard(
      {Key key,
      @required this.controller,
      this.validatorEmptyText: "Field shouldn't be left empty",
      @required this.label,
      @required this.validatorErrorText,
      @required this.validationStringLength,
      @required this.hintText});

  final TextEditingController controller;
  final String hintText;
  final String label;
  final String validatorEmptyText;
  final String validatorErrorText;
  final int validationStringLength;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Blur(
        blur: 4,
        // color: Colors.white,
        // style: NeuomorphicStyle.Flat,
        // opacity: 0.7,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            validator: (val) {
              if (val == null) {
                return null;
              }
              if (val.isEmpty) {
                return validatorEmptyText;
              } else if (val.trim().length < validationStringLength) {
                return validatorErrorText;
              } else {
                return null;
              }
            },
            // onSaved: (val) => phoneNo = val,
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              //enabledBorder: InputBorder.none,
              // filled: true,
              // fillColor: Colors.white,
              labelText: label,
              labelStyle: TextStyle(fontSize: 15.0),
              hintText: hintText,
            ),
          ),
        ),
      ),
    );
  }
}
