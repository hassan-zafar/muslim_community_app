class CommunityServiceModel {
  final String id;
  final String communityName;
  final String imageUrl;
  final String websiteLink;
  final String description;
  final String location;
  final String token;

  final bool isApproved;

  final String email;
  final String userId;
  CommunityServiceModel(
      {this.id,
      this.communityName,
      this.description,
      this.imageUrl,
      this.location,
      this.websiteLink,
      this.userId,
      this.token,
      this.email,
      this.isApproved});

  Map<String, dynamic> toMap() {
    return {};
  }

  factory CommunityServiceModel.fromDocument(doc) {
    return CommunityServiceModel(
      id: doc.data()["id"],
      communityName: doc.data()["communityName"],
      description: doc.data()["description"],
      imageUrl: doc.data()["imageUrl"],
      location: doc.data()["location"],
      websiteLink: doc.data()["websiteLink"],
      isApproved: doc.data()["isApproved"],
      email: doc.data()["email"],
      userId: doc.data()["userId"],
      token: doc.data()["token"],
    );
  }
}
