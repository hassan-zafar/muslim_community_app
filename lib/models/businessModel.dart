class BusinessModel {
  final String id;

  final String businessName;
  final String imageUrl;
  final String websiteLink;
  final String description;
  final String location;
  final bool approve;
  final String userId;
  final String email;
  final String token;

  BusinessModel(
      {this.id,
      this.businessName,
      this.description,
      this.imageUrl,
      this.location,
      this.websiteLink,
      this.email,
      this.userId,
      this.token,
      this.approve});

  Map<String, dynamic> toMap() {
    return {};
  }

  factory BusinessModel.fromDocument(doc) {
    return BusinessModel(
      id: doc.data()["id"],
      businessName: doc.data()["businessName"],
      description: doc.data()["description"],
      imageUrl: doc.data()["imageUrl"],
      location: doc.data()["location"],
      websiteLink: doc.data()["websiteLink"],
      approve: doc.data()["approve"],
      userId: doc.data()["userId"],
      email: doc.data()["email"],
      token: doc.data()["token"],
    );
  }
}
