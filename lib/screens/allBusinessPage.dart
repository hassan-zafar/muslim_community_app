import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:windsor_essex_muslim_care/screens/productDetails.dart';

import '../constants.dart';

class AllBusinessesPage extends StatefulWidget {
  @override
  _AllBusinessesPageState createState() => _AllBusinessesPageState();
}

class _AllBusinessesPageState extends State<AllBusinessesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundColorBoxDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          children: [
            businessesTile(
                businessName: "Any Business",
                location: "Block A, Etc Etc",
                imageLink:
                    "https://upmetrics.co/assets/media/convenience-store-business-plan-example.jpg"),
            businessesTile(
                businessName: "Grossery Store",
                imageLink:
                    "https://images.unsplash.com/photo-1578916171728-46686eac8d58?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGdyb2NlcnklMjBzdG9yZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
                location: "Block B, bla bla Etc Etc"),
            businessesTile(
                businessName: "Coffee Shop",
                location: "Block A, blaadasd Etc Etc",
                imageLink:
                    "https://images.unsplash.com/photo-1453614512568-c4024d13c247?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y29mZmVlJTIwc2hvcHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80"),
            businessesTile(
                businessName: "Shoe Mart",
                imageLink:
                    "https://i.pinimg.com/originals/e0/66/2b/e0662b9290406182ef0b6d6e6b5192a0.jpg",
                location: "Block A, North east Etc Etc"),
          ],
        ),
      ),
    );
  }

  Padding businessesTile({
    @required String businessName,
    @required String location,
    @required String imageLink,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 40.0, right: 40, top: 10, bottom: 10),
      child: GestureDetector(
        onTap: () => Get.to(() => BusinessDetails(
              businessName: businessName,
              imageUrl: imageLink,
              location: location,
            )),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: imageLink,
                child: Container(
                  height: 120,
                  width: 350,
                  child: CachedNetworkImage(
                    height: 100,
                    imageUrl: imageLink,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: businessName,
                      child: Text(
                        businessName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 12),
                    child: Text(
                      "Location: $location",
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
