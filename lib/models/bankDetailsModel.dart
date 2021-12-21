class BankDetailsModel {
  final String email;

  final String bankName;
  final String transitNo;
  final String accountNo;
  final String referenceNo;
  final String timeStamp;

  BankDetailsModel({
    this.bankName,
    this.email,
    this.transitNo,
    this.referenceNo,
    this.timeStamp,
    this.accountNo,
  });

  Map<String, dynamic> toMap() {
    return {};
  }

  factory BankDetailsModel.fromDocument(doc) {
    return BankDetailsModel(
      bankName: doc.data()["bankName"],
      email: doc.data()["email"],
      transitNo: doc.data()["transitNo"],
      referenceNo: doc.data()["referenceNo"],
      accountNo: doc.data()["accountNo"],
      timeStamp: doc.data()["timeStamp"],
    );
  }
}
