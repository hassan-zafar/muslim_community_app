import 'package:firebase_auth/firebase_auth.dart';
import 'package:windsor_essex_muslim_care/Database/database.dart';
import 'package:windsor_essex_muslim_care/models/userModel.dart';
import 'package:windsor_essex_muslim_care/tools/custom_toast.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  // AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  // Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.

  Future<void> forgetPassword({String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> logIn({
    String email,
    final String password,
  }) async {
    try {
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return result.user.uid;
    } on FirebaseAuthException catch (e) {
      errorToast(message: e.message);
      return null;
    }
  }

  Future<User> signUp({
    String password,
    final String userId,
    final String firstName,
    final String middleName,
    final String displayName,
    final String lastName,
    final String nextToKinName,
    final timestamp,
    final String email,
    final String postalCode,
    final String phoneNo,
    final String cellNo,
    final String homePhoneNo,
    final String emergencyPhoneNo,
    final String emergencyName,
    final String city,
    final bool isCanadianCitizen,
    final bool hasWillPrepared,
    final bool workAsVolunteer,
    final String immigrationStatus,
    final String accountNo,
    final String transitNo,
    final String referenceNo,
    final List dependents,
    final String bankName,
  }) async {
    try {
      final UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((Object obj) {
        errorToast(message: obj.toString());
      });
      final User user = result.user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      if (user != null) {
        final UserModel currentUser = UserModel(
            userId: user.uid,
            displayName: displayName,
            phoneNo: phoneNo.trim(),
            email: email.trim(),
            password: password,
            cellNo: cellNo,
            city: city,
            emergencyName: emergencyName,
            emergencyPhoneNo: emergencyPhoneNo,
            firstName: firstName,
            hasWillPrepared: hasWillPrepared,
            homePhoneNo: homePhoneNo,
            immigrationStatus: immigrationStatus,
            isCanadianCitizen: isCanadianCitizen,
            lastName: lastName,
            middleName: middleName,
            nextToKinName: nextToKinName,
            postalCode: postalCode,
            timestamp: timestamp,
            dependents: dependents,
            isAdmin: false,
            workAsVolunteer: workAsVolunteer);
        await DatabaseMethods().addUserInfoToFirebase(
            userModel: currentUser, userId: user.uid, email: email);
        await DatabaseMethods().addBankInfoToFirebase(
            accountNo: accountNo,
            bankName: bankName,
            email: email,
            userId: user.uid,
            referenceNo: referenceNo,
            transitNo: transitNo);
      }
      return user;
    } on FirebaseAuthException catch (e) {
      errorToast(message: e.message);
      return null;
    }
  }
}
