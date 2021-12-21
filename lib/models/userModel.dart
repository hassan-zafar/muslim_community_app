class UserModel {
  final String userId;
  final String firstName;
  final String middleName;
  final String displayName;
  final String androidNotificationToken;
  final String password;
  final String lastName;
  final String nextToKinName;
  final String timestamp;
  final bool isAdmin;
  final String email;
  final String postalCode;
  final String phoneNo;
  final String cellNo;
  final String homePhoneNo;
  final String emergencyPhoneNo;
  final String emergencyName;
  final String city;
  final bool isCanadianCitizen;
  final bool hasWillPrepared;
  final bool workAsVolunteer;
  final String immigrationStatus;
  final List dependents;
  UserModel({
    this.userId,
    this.firstName,
    this.middleName,
    this.password,
    this.displayName,
    this.lastName,
    this.nextToKinName,
    this.timestamp,
    this.email,
    this.postalCode,
    this.phoneNo,
    this.cellNo,
    this.homePhoneNo,
    this.emergencyPhoneNo,
    this.emergencyName,
    this.city,
    this.hasWillPrepared,
    this.immigrationStatus,
    this.isAdmin,
    this.isCanadianCitizen,
    this.workAsVolunteer,
    this.androidNotificationToken,
    this.dependents,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "displayName": displayName,
      "password": password,
      "firstName": firstName,
      "middleName": middleName,
      "lastName": lastName,
      "nextToKinName": nextToKinName,
      "timestamp": timestamp,
      "postalCode": postalCode,
      "email": email,
      "cellNo": cellNo,
      "homePhoneNo": homePhoneNo,
      "emergencyPhoneNo": emergencyPhoneNo,
      "emergencyName": emergencyName,
      "city": city,
      "immigrationStatus": immigrationStatus,
      "isCanadianCitizen": isCanadianCitizen,
      "workAsVolunteer": workAsVolunteer,
      "hasWillPrepared": hasWillPrepared,
      "phoneNo": phoneNo,
      "isAdmin": isAdmin,
      "androidNotificationToken": androidNotificationToken,
      "dependents": dependents,
    };
  }

  factory UserModel.fromMap(Map map) {
    return UserModel(
      userId: map["userId"],
      firstName: map["firstName"],
      displayName: map["displayName"],
      password: map["password"],
      middleName: map["middleName"],
      lastName: map["lastName"],
      nextToKinName: map["nextToKinName"],
      timestamp: map["timestamp"],
      postalCode: map["postalCode"],
      email: map["email"],
      cellNo: map["cellNo"],
      homePhoneNo: map["homePhoneNo"],
      emergencyPhoneNo: map["emergencyPhoneNo"],
      emergencyName: map["emergencyName"],
      city: map["city"],
      immigrationStatus: map["immigrationStatus"],
      isCanadianCitizen: map["isCanadianCitizen"],
      workAsVolunteer: map["workAsVolunteer"],
      hasWillPrepared: map["hasWillPrepared"],
      phoneNo: map["phoneNo"],
      isAdmin: map["isAdmin"],
      androidNotificationToken: map["androidNotificationToken"],
      dependents: map["dependents"],
    );
  }

  factory UserModel.fromDocument(doc) {
    return UserModel(
      userId: doc.data()["userId"],
      firstName: doc.data()["firstName"],
      password: doc.data()["password"],
      middleName: doc.data()["middleName"],
      displayName: doc.data()["displayName"],
      lastName: doc.data()["lastName"],
      nextToKinName: doc.data()["nextToKinName"],
      timestamp: doc.data()["timestamp"],
      postalCode: doc.data()["postalCode"],
      email: doc.data()["email"],
      cellNo: doc.data()["cellNo"],
      homePhoneNo: doc.data()["homePhoneNo"],
      emergencyPhoneNo: doc.data()["emergencyPhoneNo"],
      emergencyName: doc.data()["emergencyName"],
      city: doc.data()["city"],
      immigrationStatus: doc.data()["immigrationStatus"],
      isCanadianCitizen: doc.data()["isCanadianCitizen"],
      workAsVolunteer: doc.data()["workAsVolunteer"],
      hasWillPrepared: doc.data()["hasWillPrepared"],
      phoneNo: doc.data()["phoneNo"],
      isAdmin: doc.data()["isAdmin"],
      androidNotificationToken: doc.data()["androidNotificationToken"],
      dependents: doc.data()["dependents"],
    );
  }
}
