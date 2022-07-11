import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/models/communityServiceModel.dart';
import 'package:windsor_essex_muslim_care/screens/communityServicesPages/addNewCommunity.dart';
import 'package:windsor_essex_muslim_care/screens/landingPage.dart';
import 'package:windsor_essex_muslim_care/tools/loading.dart';

import 'CommunityServiceDetails.dart';

class AllCommunityServicesPage extends StatefulWidget {
  @override
  _AllCommunityServicesPageState createState() =>
      _AllCommunityServicesPageState();
}

class _AllCommunityServicesPageState extends State<AllCommunityServicesPage> {
  ScrollController controller = ScrollController();
  double topContainer = 0;
  List<CommunityServiceModel> allApprovedCommunities = [];
  List<CommunityServiceModel> allPendingCommunities = [];
  bool showApproved = true;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getCommunities();
    controller.addListener(() {
      double value = controller.offset / 180;
      setState(() {
        topContainer = value;
      });
    });
  }

  getCommunities() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        this.allApprovedCommunities = [];
        this.allPendingCommunities = [];
      });
    }
    QuerySnapshot communitySnapShot = await communityRef.get();
    List<CommunityServiceModel> tempApprovedCommunities = [];
    List<CommunityServiceModel> tempPendingCommunities = [];
    communitySnapShot.docs.map((doc) {
      CommunityServiceModel aBusiness = CommunityServiceModel.fromDocument(doc);
      if (aBusiness.isApproved != null && aBusiness.isApproved) {
        tempApprovedCommunities.add(CommunityServiceModel.fromDocument(doc));
      } else {
        tempPendingCommunities.add(CommunityServiceModel.fromDocument(doc));
      }
    }).toList();
    if (mounted) {
      setState(() {
        this.allApprovedCommunities = tempApprovedCommunities;
        this.allPendingCommunities = tempPendingCommunities;

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
              Get.to(() => AddNewCommunity()).then((value) => getCommunities());
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
            label: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline_outlined),
                    Text(" Add Your Community"),
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
                        var selectedCommunities = showApproved
                            ? allApprovedCommunities
                            : allPendingCommunities;
                        if (selectedCommunities == null ||
                            selectedCommunities.isEmpty) {
                          return Center(
                            child: Text("No Business Has yet been added"),
                          );
                        } else if (selectedCommunities[index] != null) {
                          return communityTile(
                            communityName:
                                selectedCommunities[index].communityName,
                            communityModel: selectedCommunities[index],
                            location: selectedCommunities[index].location,
                            communityDescription:
                                selectedCommunities[index].description,
                            website: selectedCommunities[index].websiteLink,
                            imageLink: selectedCommunities[index].imageUrl,
                          );
                        } else
                          return null;
                      },
                      itemCount: showApproved
                          ? allApprovedCommunities.length
                          : allPendingCommunities.length,
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
                                        "${allApprovedCommunities.length}  Approved")),
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
                                        "${allPendingCommunities.length}  Pending")),
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

  Padding communityTile({
    @required CommunityServiceModel communityModel,
    @required String communityName,
    @required String location,
    @required String imageLink,
    @required String communityDescription,
    @required String website,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Get.to(
          () => CommunityServiceDetails(
            // businessName: businessName,
            // imageUrl: imageLink,
            // location: location,
            // businessDescription: businessDescription,
            // website: website,
            communityModel: communityModel,
          ),
        ).then((value) => getCommunities()),
        child: Container(
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
                      tag: communityName,
                      child: Text(
                        communityName,
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
