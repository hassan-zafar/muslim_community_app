import 'package:flutter/material.dart';

TextStyle directorTextStyle() {
  return TextStyle(fontSize: 16, fontWeight: FontWeight.w200);
}

Column boardOfDirectorsList() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Sr. Rubina Waqar, President",
          style: directorTextStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Sr. Abeer Rizek, Secretary",
          style: directorTextStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Br. Gihad Gawanmeh, Board Member",
          style: directorTextStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Br. Sami Issa, Board Member",
          style: directorTextStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Sh. Abdullah Hammoud, Imam & Religious Advisor",
          style: directorTextStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Sr. Waheeda Khan, School Principal",
          style: directorTextStyle(),
        ),
      ),
    ],
  );
}
