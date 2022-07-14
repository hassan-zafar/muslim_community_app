import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:windsor_essex_muslim_care/Database/database.dart';
import 'package:windsor_essex_muslim_care/config/collection_names.dart';
import 'package:windsor_essex_muslim_care/constants.dart';
import 'package:windsor_essex_muslim_care/screens/landingPage.dart';
import 'package:windsor_essex_muslim_care/tools/notificationHandler.dart';

class AddNewCommunity extends StatefulWidget {
  AddNewCommunity();
  @override
  _AddNewCommunityState createState() => _AddNewCommunityState();
}

class _AddNewCommunityState extends State<AddNewCommunity> {
  final _textFormkey = GlobalKey<FormState>();
  File file;
  String postId = Uuid().v4();
  bool isUploading = false;
  String communityTitle, postDescription, postSubheading;
  ScrollController _scrollController = ScrollController();
  TextEditingController _communityNameController = TextEditingController();
  TextEditingController _communityDescriptionController =
      TextEditingController();
  TextEditingController _locationController = TextEditingController();
  // TextEditingController _websiteUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: backgroundColorBoxDecorationLogo(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text("Add Community Service"),
            elevation: 0,
            actions: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton.icon(
                  onPressed: () {
                    buildMediaDialog(context);
                  },
                  icon: Icon(
                    Icons.add,
                    size: 20.0,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  label: Text(
                    'Add Media',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ),
              )
            ],
          ),
          body: WillPopScope(
            onWillPop: _onBackPressed,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  isUploading ? LinearProgressIndicator() : Text(""),
                  file == null
                      ? Container()
                      : Container(
                          height: 220.0,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(file),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  Form(
                      key: _textFormkey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 25.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: Container(
                              
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onSaved: (val) => communityTitle = val,
                                  validator: (val) => val.trim().length < 3
                                      ? 'Community Title Too Short'
                                      : null,
                                  controller: _communityNameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Community Service Name",
                                    hintText: "Min length 3",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(left: 18.0, right: 18.0),
                          //   child: Blur(
                          //     blur: 4,
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: TextFormField(
                          //         onSaved: (val) => postSubheading = val,
                          //         validator: (val) => val.trim().length < 3
                          //             ? 'invalid site URL'
                          //             : null,
                          //         controller: _websiteUrlController,
                          //         decoration: InputDecoration(
                          //           border: InputBorder.none,
                          //           labelText: "Enter Your Website Url",
                          //           hintText: "Min length 3",
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 25.0,
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: Container(
                              
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onSaved: (val) => postDescription = val,
                                  validator: (val) => val.trim().length < 1
                                      ? 'Please add your community description'
                                      : null,
                                  controller: _communityDescriptionController,
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Community Service Description",
                                    hintText:
                                        "Add description of your community service",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 18.0, right: 18.0),
                            child: Container(
                              
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  onSaved: (val) => postDescription = val,
                                  validator: (val) => val.trim().length < 1
                                      ? 'Please enter correct Location'
                                      : null,
                                  controller: _locationController,
                                  maxLines: 7,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Business Location",
                                    hintText: "Add location of your business",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          GestureDetector(
                            onTap: isUploading ? null : () => handleSubmit(),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text("Add Community"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  handleImageFromGallery() async {
    Navigator.pop(context);
    var picker = await ImagePicker().getImage(source: ImageSource.gallery);
    File file;
    file = File(picker.path);
    setState(() {
      this.file = file;
    });
  }

  Future<String> uploadImage(imageFile) async {
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('posts/$postId.jpg');
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    // storageRef.child("post_$postId.jpg").putFile(imageFile);
    // TaskSnapshot storageSnap = await uploadTask.onComplete;
    // String downloadUrl = await storageSnap.ref.getDownloadURL();
    // return downloadUrl;

    String downloadUrl;
    await uploadTask.whenComplete(() async {
      downloadUrl = await firebaseStorageRef.getDownloadURL();
    });
    // uploadTask.then((res) async {
    //   downloadUrl = await res.ref.getDownloadURL();
    // });
    return downloadUrl;
  }

  createPostInFirestore({
    String imageUrl,
    String communityName,
    String description,
    String websiteLink,
    String location,
    String eachAdminId,
    String eachAdminToken,
    String postId,
  }) {
    String postId = Uuid().v4();

    communityRef.doc(postId).set({
      "communityName": communityName,
      "imageUrl": imageUrl,
      "websiteLink": websiteLink,
      "description": description,
      "location": location,
      "id": postId,
      "userEmail": email,
      "token": token,
      "userId": userUid,
      "isApproved": false,
    });

    DatabaseMethods().addAnnouncements(
        postId: postId,
        description: "A New Community Has been Added",
        imageUrl: imageUrl,
        eachUserId: eachAdminId,
        eachUserToken: eachAdminToken,
        announcementTitle: "Community Added");
  }

  handleSubmit() async {
    final _form = _textFormkey.currentState;
    if (file == null) {
      BotToast.showText(text: "Image must be Added");
    } else {
      if (_form.validate()) {
        setState(() {
          isUploading = true;
        });
        _scrollController.animateTo(0.0,
            duration: Duration(milliseconds: 600), curve: Curves.easeOut);
        // ignore: unnecessary_statements
        file != null ? await compressImage() : null;
        String imageUrl = file != null
            ? await uploadImage(file).catchError((onError) {
                isUploading = false;
                BotToast.showText(text: "Couldn't connect to servers!!");
              })
            : "";
        allUsersList.forEach((e) async {
          if (e.isAdmin) {
            await createPostInFirestore(
                imageUrl: imageUrl,
                communityName: _communityNameController.text,
                description: _communityDescriptionController.text,
                postId: postId,
                eachAdminId: e.userId,
                eachAdminToken: e.androidNotificationToken,
                // websiteLink: _websiteUrlController.text,
                location: _locationController.text);
            sendAndRetrieveMessage(
                token: e.androidNotificationToken,
                message: "New Community has been added",
                context: context,
                imageUrl: imageUrl,
                title: "New Community Added");
          }
        });

        _communityDescriptionController.clear();
        _communityNameController.clear();
        // _websiteUrlController.clear();
        _locationController.clear();
        setState(() {
          file = null;
          isUploading = false;
          postId = Uuid().v4();
        });
        Navigator.pop(context);
      }
      BotToast.showText(text: "New Community Added");
    }
  }

  Future<bool> _onBackPressed() {
    isUploading
        ? BotToast.showText(text: "Sorry can't go back as post is being added")
        : Navigator.of(context).pop();
    return null;
  }

  buildMediaDialog(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  //Navigator.pop(context);
                  handleImageFromGallery();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Upload Image',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Cancel'),
                    ],
                  )),
                ),
              )
            ],
          );
        });
  }
}
