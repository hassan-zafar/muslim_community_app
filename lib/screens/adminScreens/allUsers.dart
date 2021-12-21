import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/models/userModel.dart';
import 'package:windsor_essex_muslim_care/screens/adminScreens/userDetailsPage.dart';
import 'package:windsor_essex_muslim_care/screens/landingPage.dart';
import 'package:windsor_essex_muslim_care/tools/loading.dart';

class UserNSearch extends StatefulWidget {
  // final UserModel currentUser;
  // UserNSearch({this.currentUser});
  @override
  _UserNSearchState createState() => _UserNSearchState();
}

class _UserNSearchState extends State<UserNSearch>
    with AutomaticKeepAliveClientMixin<UserNSearch> {
  Future<QuerySnapshot> searchResultsFuture;
  TextEditingController searchController = TextEditingController();

  String typeSelected = 'users';
  handleSearch(String query) {
    Future<QuerySnapshot> users =
        userRef.where("displayName", isGreaterThanOrEqualTo: query).get();
    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
  }

  AppBar buildSearchField(context) {
    return AppBar(
      backgroundColor: Theme.of(context).accentColor,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: clearSearch,
            )),
        onFieldSubmitted: handleSearch,
      ),
    );
  }

  buildSearchResult() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LoadingIndicator();
        }
        List<UserResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          String completeName =
              doc.data()["displayName"].toString().toLowerCase().trim();
          if (completeName.contains(searchController.text)) {
            UserModel user = UserModel.fromDocument(doc);
            UserResult searchResult = UserResult(user);
            searchResults.add(searchResult);
          }
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecorationLogo(),
        child: Scaffold(
          appBar: buildSearchField(context),
          body: searchResultsFuture == null
              ? buildAllUsers()
              : buildSearchResult(),
        ),
      ),
    );
  }

  buildAllUsers() {
    return StreamBuilder(
        stream: userRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingIndicator();
          }
          List<UserResult> userResults = [];
          List<UserResult> allAdmins = [];

          snapshot.data.docs.forEach((doc) {
            UserModel user = UserModel.fromDocument(doc);

            //remove auth user from recommended list
            if (user.isAdmin) {
              UserResult adminResult = UserResult(user);
              allAdmins.add(adminResult);
            } else {
              UserResult userResult = UserResult(user);
              userResults.add(userResult);
            }
          });
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlassContainer(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        typeSelected = "users";
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          GlassContainer(
                            opacity: 0.7,
                            shadowStrength: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "${userResults.length}",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  Icon(
                                    Icons.person_outline,
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    "Total Users",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      typeSelected = "admin";
                                    });
                                  },
                                  child: GlassContainer(
                                      opacity: 0.7,
                                      shadowStrength: 8,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "All Admins ${allAdmins.length}",
                                          style: TextStyle(fontSize: 20.0),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  typeSelected == 'admin'
                      ? Column(
                          children: allAdmins,
                        )
                      : Text(""),
                  typeSelected == 'users'
                      ? Column(
                          children: userResults,
                        )
                      : Text(''),
                ],
              ),
            ),
          );
        });
  }
}

class UserResult extends StatelessWidget {
  final UserModel user;
  UserResult(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onLongPress: () => makeAdmin(context),
            onTap: () => Get.to(() => UserDetailsPage(
                  userDetails: user,
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassContainer(
                opacity: 0.6,
                shadowStrength: 8,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person),
                  ),
                  title: Text(
                    user.displayName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user.displayName,
                  ),
                  trailing: Text(user.isAdmin ? "Admin" : "User"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  makeAdmin(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              user.isAdmin && user.userId != userUid
                  ? SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        makeAdminFunc("Rank changed to User");
                      },
                      child: Text(
                        'Make User',
                      ),
                    )
                  : SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        makeAdminFunc("Upgraded to Admin");
                      },
                      child: Text(
                        'Make Admin',
                      ),
                    ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  deleteUser();
                },
                child: Text(
                  'Delete User',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  void makeAdminFunc(String msg) {
    userRef.doc(user.userId).update({"isAdmin": !user.isAdmin});
    addToFeed(msg);

    BotToast.showText(text: msg);
  }

  addToFeed(String msg) {
    // activityFeedRef.doc(user.id).collection('feedItems').add({
    //   "type": "mercReq",
    //   "commentData": msg,
    //   "userName": user.displayName,
    //   "userId": user.id,
    //   "userProfileImg": user.photoUrl,
    //   "ownerId": currentUser.id,
    //   "mediaUrl": currentUser.photoUrl,
    //   "timestamp": timestamp,
    //   "productId": "",
    // });
  }

  void deleteUser() {
    userRef.doc(user.userId).delete();
    BotToast.showText(text: 'User Deleted Refresh');
  }
}
