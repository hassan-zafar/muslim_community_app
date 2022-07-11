import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:windsor_essex_muslim_care/Database/database.dart';
import 'package:windsor_essex_muslim_care/commonUIFunctions.dart';
import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/models/communityServiceModel.dart';
import 'package:windsor_essex_muslim_care/tools/loading.dart';
import 'package:windsor_essex_muslim_care/tools/notificationHandler.dart';
import 'package:uuid/uuid.dart';

class CommunityServiceDetails extends StatefulWidget {
  final CommunityServiceModel communityModel;
  CommunityServiceDetails({
    this.communityModel,
  });
  @override
  _CommunityServiceDetailsState createState() =>
      _CommunityServiceDetailsState();
}

class _CommunityServiceDetailsState extends State<CommunityServiceDetails> {
  bool _isApproved = false;

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _isApproved = widget.communityModel.isApproved;
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
                tag: widget.communityModel.imageUrl,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            widget.communityModel.imageUrl,
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
                                    tag: widget.communityModel.communityName,
                                    child: Text(
                                      widget.communityModel.communityName,
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
                                  child:
                                      Text(widget.communityModel.description),
                                ),
                              ],
                            ),
                      
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Service location",
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
                                    child: Text(widget.communityModel.location),
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

                  // GestureDetector(
                  //   onTap: () {
                  //     launch(widget.communityModel.websiteLink);
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.all(12),
                  //     child: buildSignUpLoginButton(
                  //       context: context,
                  //       btnText: "Visit Site",
                  //       hasIcon: false,
                  //       textColor: Colors.white,
                  //       color: containerColor,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  _isApproved
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            communityRef
                                .doc(widget.communityModel.id)
                                .delete()
                                .then((value) {
                              Navigator.pop(context);
                              BotToast.showText(text: "Community Deleted");
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
                                      "Delete Community Permanently",
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
                    bool tempApproved = !_isApproved;

                    communityRef
                        .doc(widget.communityModel.id)
                        .update({"isApproved": tempApproved}).then((value) {
                      sendAndRetrieveMessage(
                          token: widget.communityModel.token,
                          message: tempApproved
                              ? "Your Community has been Approved by the Admin"
                              : "Your Community has been Rejected by the Admin",
                          imageUrl: widget.communityModel.imageUrl,
                          context: context,
                          title: "Community Alert");
                      String postId = Uuid().v4();
                      DatabaseMethods().addAnnouncements(
                          postId: postId,
                          announcementTitle: "Community Alert",
                          description:
                              "Your Community has been Approved by the Admin");
                      setState(() {
                        _isLoading = false;
                        _isApproved = tempApproved;
                      });
                      BotToast.showText(
                          text: _isApproved
                              ? "Service Approved"
                              : "service Disapproved");
                    });
                  },
                  child: _isLoading
                      ? LoadingIndicator()
                      : smallPositionedColored(
                          text: _isApproved ? "Approved" : "Disapproved",
                          color: _isApproved ? Colors.lime[600] : Colors.red,
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
