import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:windsor_essex_muslim_care/Database/database.dart';
import 'package:windsor_essex_muslim_care/commonUIFunctions.dart';
import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/models/businessModel.dart';
import 'package:windsor_essex_muslim_care/tools/loading.dart';
import 'package:windsor_essex_muslim_care/tools/notificationHandler.dart';
import 'package:uuid/uuid.dart';

class BusinessDetails extends StatefulWidget {
  final BusinessModel businessModel;
  BusinessDetails({
    this.businessModel,
  });
  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  bool isApproved = false;

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    isApproved = widget.businessModel.approve;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColorBoxDecoration(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Hero(
                tag: widget.businessModel.imageUrl,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.businessModel.imageUrl,
                          ),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter)),
                ),
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 320,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Hero(
                                    tag: widget.businessModel.businessName,
                                    child: Text(
                                      widget.businessModel.businessName,
                                      style: titleTextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Information",
                                      style: cardHeadingTextStyle()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(widget.businessModel.description),
                                ),
                              ],
                            ),
                            // Positioned(
                            //   top: 4,
                            //   right: 7,
                            //   child: smallPositionedColored(text: "Open"),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
//goodie bag pickup location
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Business location",
                              style: cardHeadingTextStyle(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.businessModel.location),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                          left: 16,
                                          right: 16),
                                      child: Icon(Icons.undo),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      launch(widget.businessModel.websiteLink);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: buildSignUpLoginButton(
                        context: context,
                        btnText: "Visit Site",
                        hasIcon: false,
                        textColor: Colors.white,
                        color: containerColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isApproved
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            businessRef
                                .doc(widget.businessModel.id)
                                .delete()
                                .then((value) {
                              Navigator.pop(context);
                              BotToast.showText(text: "Business Deleted");
                            });
                          },
                          child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                    child: Text(
                                      "Delete Business Permanently",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Positioned(
                right: 60,
                top: 15,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _isLoading = true;
                    });
                    bool tempApprove = !isApproved;
                    businessRef
                        .doc(widget.businessModel.id)
                        .update({"approve": tempApprove}).then((value) {
                      sendAndRetrieveMessage(
                          token: widget.businessModel.token,
                          message: tempApprove
                              ? "Your Business has been Approved by the Admin"
                              : "Your Business has been Rejected by the Admin",imageUrl: widget.businessModel.imageUrl,
                          context: context,
                          title: "Business Alert");
                      String postId = Uuid().v4();
                      DatabaseMethods().addAnnouncements(
                          postId: postId,
                          announcementTitle: "Business Alert",
                          description:
                              "Your Business has been Approved by the Admin");
                      setState(() {
                        isApproved = tempApprove;
                        _isLoading = false;
                      });
                      BotToast.showText(
                          text: isApproved
                              ? "Business Approved"
                              : "Business Disapproved");
                    });
                  },
                  child: _isLoading
                      ? LoadingIndicator()
                      : smallPositionedColored(
                          text: isApproved ? "Approved" : "Disapproved",
                          color: isApproved ? Colors.lime[600] : Colors.red,
                        ),
                ),
              ),
              Positioned(
                top: 15,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.reply_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

cardHeadingTextStyle() {
  return TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
}
