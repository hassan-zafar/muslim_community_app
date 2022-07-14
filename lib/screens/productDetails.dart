import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../commonUIFunctions.dart';
import '../constants.dart';

class BusinessDetails extends StatefulWidget {
  final String imageUrl;
  final String businessName;
  final String location;
  BusinessDetails({this.businessName, this.imageUrl, this.location});
  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColorBoxDecoration(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Hero(
                tag: widget.imageUrl,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(widget.imageUrl),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter)),
                ),
              ),
              ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 280,
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
                                    tag: widget.businessName,
                                    child: Text(
                                      widget.businessName,
                                      style: titleTextStyle(fontSize: 22),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "asdjkha sdklfj sdlwke ww  werio werwle fsdf lksdf asjdkha jkad kfsdh fkjf werjk wr hkjwerh kwrj werh kjawr harjk ewrh jkaer hawerkj aerh aerjk aerh "),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Information",
                                      style: cardHeadingTextStyle()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4.0, bottom: 8, left: 16, right: 8),
                                  child: Text(
                                    "Opening Time: 9:00 - 16:00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 4,
                              right: 7,
                              child: smallPositionedColored(text: "Open"),
                            ),
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
                                    child: Text("Block A, Model Town,Blabla"),
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
//store details
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Store Details",
                                    style: cardHeadingTextStyle(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: widget.imageUrl,
                                            height: 45,
                                          )),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              widget.businessName,
                                              style: cardHeadingTextStyle(),
                                            ),
                                          ),
                                          Text(widget.location),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 30,
                              right: 8,
                              child: smallPositionedColored(text: "View More"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // _isLoadingReviews
                  //     ? bouncingGridProgress()
                  //     : buildCommentReviews(
                  //         title: "Review",
                  //         //  commentsNo: 340,
                  //         isComment: false),
                  // _isLoadingComments
                  //     ? bouncingGridProgress()
                  //     : buildCommentReviews(
                  //         title: "Comments",
                  //         // commentsNo: 530,
                  //         isComment: true),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      
                      // width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "80% people love this store",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      // _showBottomSheet(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: buildSignUpLoginButton(
                        context: context,
                        btnText: "Reserve",
                        textColor: Colors.white,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
              Positioned(
                right: 60,
                top: 15,
                child: smallPositionedColored(
                  text: "Open",
                  color: Colors.lime[600],
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
