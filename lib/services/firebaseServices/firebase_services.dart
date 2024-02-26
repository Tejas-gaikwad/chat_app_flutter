import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseServices {
  static Future<String> uploadFileToFirebaseStorage(File file) async {
    try {
      // Create a reference to the Firebase Storage location
      String fileName = basename(file.path);

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);

      // Get the download URL
      String downloadURL =
          await (await firebaseStorageRef.putFile(file)).ref.getDownloadURL();

      // Return the download URL
      return downloadURL;
    } catch (error) {
      return ''; // Handle error as needed in your app
    }
  }
}
