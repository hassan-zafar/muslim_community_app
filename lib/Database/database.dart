import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:windsor_essex_muslim_care/Database/local_database.dart';
import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/models/announcementsModel.dart';
import 'package:windsor_essex_muslim_care/models/userModel.dart';
import 'package:windsor_essex_muslim_care/screens/landingPage.dart';
import 'package:windsor_essex_muslim_care/tools/custom_toast.dart';

class DatabaseMethods {
  // Future<Stream<QuerySnapshot>> getproductData() async {
  //   return FirebaseFirestore.instance.collection(productCollection).snapshots();
  // }

  Future addUserInfoToFirebase(
      {@required UserModel userModel,
      @required String userId,
      @required email}) async {
    final Map<String, dynamic> userInfoMap = userModel.toMap();
    return FirebaseFirestore.instance
        .collection(userDataCollection)
        .doc(userId)
        .set(userInfoMap)
        .then((value) {
      createToken(userId);

      UserLocalData().setUserUID(userModel.userId);
      UserLocalData().setUserEmail(userModel.email);
      UserLocalData().setIsAdmin(userModel.isAdmin);
    }).catchError(
      (Object obj) {
        errorToast(message: obj.toString());
      },
    );
  }

  addAnnouncements(
      {final String postId,
      final String announcementTitle,
      final String imageUrl,
      final String eachUserId,
      String eachUserToken,
      final String description}) async {
    FirebaseFirestore.instance
        .collection("announcements")
        .doc(eachUserId)
        .collection("userAnnouncements")
        .doc(postId)
        .set({
      "announcementId": postId,
      "announcementTitle": announcementTitle,
      "description": description,
      "timestamp": DateTime.now(),
      "token": eachUserToken,
      "imageUrl": imageUrl,
      "userId": userUid
    });
  }

  createToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      userRef.doc(uid).update({"androidNotificationToken": token});
      UserLocalData().setToken(token);
    });
  }

  Future getAnnouncements() async {
    List<AnnouncementsModel> tempAllAnnouncements = [];
    QuerySnapshot tempAnnouncementsSnapshot = await FirebaseFirestore.instance
        .collection('announcements')
        .doc(userUid)
        .collection("userAnnouncements")
        .get();
    tempAnnouncementsSnapshot.docs.forEach((element) {
      tempAllAnnouncements.add(AnnouncementsModel.fromDocument(element));
    });
    return tempAllAnnouncements;
  }

  Future addBankInfoToFirebase(
      {final String accountNo,
      final String transitNo,
      final String referenceNo,
      final String bankName,
      final String email,
      @required final String userId}) async {
    // final Map<String, dynamic> userInfoMap = userModel.toMap();
    return FirebaseFirestore.instance
        .collection(bankInfoCollection)
        .doc(userId)
        .set({
      "accountNo": accountNo,
      "email": email,
      "referenceNo": referenceNo,
      "transitNo": transitNo,
      "bankName": bankName,
    }).catchError(
      (Object obj) {
        errorToast(message: obj.toString());
      },
    );
  }

  Future fetchUserInfoFromFirebase({@required String uid}) async {
    final DocumentSnapshot _user = await userRef.doc(uid).get();
    createToken(uid);

    UserModel currentUser = UserModel.fromDocument(_user);
    UserLocalData().setUserUID(currentUser.androidNotificationToken);

    UserLocalData().setUserUID(currentUser.userId);
    UserLocalData().setUserEmail(currentUser.email);
    UserLocalData().setIsAdmin(currentUser.isAdmin);
    isAdmin = currentUser.isAdmin;
    return currentUser;
    // UserLocalData().setUserModelData(_userDataString);
  }
}
