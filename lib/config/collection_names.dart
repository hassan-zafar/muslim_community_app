import 'package:cloud_firestore/cloud_firestore.dart';

const String userDataCollection = "userData";
const String bankInfoCollection = "bankInfo";
const String communityServicesCollection = "communityServices";
final bankInfoRef =
    FirebaseFirestore.instance.collection(bankInfoCollection);
const String businessDetailsCollection = "businessDetails";
final userRef = FirebaseFirestore.instance.collection(userDataCollection);
final businessRef =
    FirebaseFirestore.instance.collection(businessDetailsCollection);
final communityRef =
    FirebaseFirestore.instance.collection(communityServicesCollection);
final announcementsRef = FirebaseFirestore.instance.collection('announcements');
