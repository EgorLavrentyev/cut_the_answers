import 'package:cloud_firestore/cloud_firestore.dart';

class App {
  static final database = FirebaseFirestore.instance;

  static init() async {
    String roomId = "ISPM";

    database.collection(roomId).add({
      "user": "123",
      "word": "123323",
    });
  }
}
