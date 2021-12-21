import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalData {
  String s = 'sd';
  SharedPreferences _preferences;
  final getStorageProference = GetStorage();

  Future init() async => _preferences = await SharedPreferences.getInstance();

  // Future<bool> logOut() => _preferences.clear();

  Future logOut() => getStorageProference.erase();
  final _userModelString = 'USERMODELSTRING';
  final _uidKey = 'UIDKEY';
  final _isLoggedIn = "ISLOGGEDIN";
  final _emailKey = 'EMAILKEY';
  final _displayNameKey = 'DISPLAYNAMEKEY';
  final _phoneNumberKey = 'PhoneNumber';
  final _imageUrlKey = 'IMAGEURLKEY';
  final _password = 'PASSWORD';
  final _isAdmin = 'ISADMIN';
  final _token = 'TOKEN';

  //
  // Setters
  //
  Future setUserModelData(String userModelString) async =>
      _preferences.setString(_userModelString, userModelString ?? "");
  Future setUserEmail(String email) async =>
      getStorageProference.write(_emailKey, email);

  Future setToken(String token) async =>
      getStorageProference.write(_token, token);

  Future setIsAdmin(bool isAdmin) async =>
      getStorageProference.write(_isAdmin, isAdmin);

  Future setUserUID(String uid) async =>
      getStorageProference.write(_uidKey, uid);
  Future setNotLoggedIn() async =>
      getStorageProference.write(_isLoggedIn, false);
  Future setLoggedIn(bool isLoggedIn) async =>
      getStorageProference.write(_isLoggedIn, isLoggedIn ?? false);
  // Future setUserUID(String uid) async =>
  //     _preferences.setString(_uidKey, uid ?? '');

  // Future setUserEmail(String email) async =>
  //     _preferences.setString(_emailKey, email ?? '');

  Future setUserDisplayName(String name) async =>
      _preferences.setString(_displayNameKey, name ?? '');

  Future setUserPhoneNumber(String number) async =>
      _preferences.setString(_phoneNumberKey, number ?? '');

  Future setUserImageUrl(String url) async =>
      _preferences.setString(_imageUrlKey, url ?? '');
  Future setUserPassword(String password) async =>
      _preferences.setString(_password, password ?? '');

  //
  // Getters
  //
  bool getIsAdmin() => getStorageProference.read(_isAdmin);
  String getUserToken() => getStorageProference.read(_token) ?? '';

  String getUserModelData() => _preferences.getString(_userModelString) ?? '';
  String getUserUIDGet() => getStorageProference.read(_uidKey) ?? '';
  bool isLoggedIn() => getStorageProference.read(_uidKey);
  String getUserUID() => _preferences.getString(_uidKey) ?? '';
  String getUserEmail() => getStorageProference.read(_emailKey) ?? '';
  String getUserDisplayName() => _preferences.getString(_displayNameKey) ?? '';
  String getUserPhoneNumber() => _preferences.getString(_phoneNumberKey) ?? '';
  String getUserPassword() => _preferences.getString(_password) ?? '';
  String getUserImageUrl() => _preferences.getString(_imageUrlKey) ?? '';
}
