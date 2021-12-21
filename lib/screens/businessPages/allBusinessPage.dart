import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/screens/businessPages/addNewBusiness.dart';
import 'package:windsor_essex_muslim_care/models/businessModel.dart';
import 'package:windsor_essex_muslim_care/screens/landingPage.dart';
import 'package:windsor_essex_muslim_care/tools/loading.dart';

import 'businessDetails.dart';

class AllBusinessesPage extends StatefulWidget {
  @override
  _AllBusinessesPageState createState() => _AllBusinessesPageState();
}

class _AllBusinessesPageState extends State<AllBusinessesPage> {
  ScrollController controller = ScrollController();
  double topContainer = 0;
  List<BusinessModel> allApprovedBusinesses = [];
  List<BusinessModel> allPendingBusinesses = [];
  bool showApproved = true;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getBusinesses();
    controller.addListener(() {
      double value = controller.offset / 180;
      setState(() {
        topContainer = value;
      });
    });
  }

  getBusinesses() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        allApprovedBusinesses = [];
        allPendingBusinesses = [];
      });
    }
    QuerySnapshot businessSnapshot = await FirebaseFirestore.instance
        .collection(businessDetailsCollection)
        .get();
    List<BusinessModel> tempApprovedBusinesses = [];
    List<BusinessModel> tempPendingBusinesses = [];
    businessSnapshot.docs.map((doc) {
      BusinessModel aBusiness = BusinessModel.fromDocument(doc);
      if (aBusiness.approve != null && aBusiness.approve) {
        tempApprovedBusinesses.add(BusinessModel.fromDocument(doc));
      } else {
        tempPendingBusinesses.add(BusinessModel.fromDocument(doc));
      }
    }).toList();
    if (mounted) {
      setState(() {
        this.allApprovedBusinesses = tempApprovedBusinesses;
        this.allPendingBusinesses = tempPendingBusinesses;

        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecorationLogo(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Get.to(() => AddNewBusiness()).then((value) => getBusinesses());
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
            label: GlassContainer(
              opacity: 0.1,
              borderRadius: BorderRadius.circular(30),
              blur: 12,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline_outlined),
                    Text(" Add Your Business"),
                  ],
                ),
              ),
            ),
          ),
          body: _isLoading
              ? LoadingIndicator()
              : Stack(
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) {
                        var selectedBusiness = showApproved
                            ? allApprovedBusinesses
                            : allPendingBusinesses;
                        if (selectedBusiness == null ||
                            selectedBusiness.isEmpty) {
                          return Center(
                            child: Text("No Business Has yet been added"),
                          );
                        } else if (selectedBusiness[index] != null) {
                          return businessesTile(
                            businessName: selectedBusiness[index].businessName,
                            businessModel: selectedBusiness[index],
                            location: selectedBusiness[index].location,
                            businessDescription:
                                selectedBusiness[index].description,
                            website: selectedBusiness[index].websiteLink,
                            imageLink: selectedBusiness[index].imageUrl,
                          );
                        } else
                          return null;
                      },
                      itemCount: showApproved
                          ? allApprovedBusinesses.length
                          : allPendingBusinesses.length,
                    ),
                    isAdmin
                        ? Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FlatButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        showApproved = true;
                                      });
                                    },
                                    icon: Icon(Icons.done),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.green,
                                    label: Text(
                                        "${allApprovedBusinesses.length}  Approved")),
                                FlatButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        showApproved = false;
                                      });
                                    },
                                    icon: Icon(Icons.approval),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.red,
                                    label: Text(
                                        "${allPendingBusinesses.length}  Pending")),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
        ),
      ),
    );
  }

  Padding businessesTile({
    @required BusinessModel businessModel,
    @required String businessName,
    @required String location,
    @required String imageLink,
    @required String businessDescription,
    @required String website,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Get.to(
          () => BusinessDetails(
            // businessName: businessName,
            // imageUrl: imageLink,
            // location: location,
            // businessDescription: businessDescription,
            // website: website,
            businessModel: businessModel,
          ),
        ).then((value) => getBusinesses()),
        child: GlassContainer(
          opacity: 0.5,
          height: 215,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: imageLink,
                child: Container(
                  height: 120,
                  width: 350,
                  child: CachedNetworkImage(
                    height: 100,
                    imageUrl: imageLink,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: businessName,
                      child: Text(
                        businessName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 12),
                    child: Text(
                      "Location: $location",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
