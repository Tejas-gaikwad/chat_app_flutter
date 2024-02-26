import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseServices {
  static Future<String> uploadFileToFirebaseStorage(File file) async {
    try {
      // Create a reference to the Firebase Storage location
      String fileName = basename(file.path);

      print("fileName  -----------    ${fileName}");

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);

      print("firebaseStorageRef  -----------    ${firebaseStorageRef}");

      // Get the download URL
      String downloadURL =
          await (await firebaseStorageRef.putFile(file)).ref.getDownloadURL();

      print("downloadURL  -----------    ${downloadURL}");

      // Return the download URL
      return downloadURL;
    } catch (error) {
      print("ERROR whle putting file in storage  ->>>   $error");
      return ''; // Handle error as needed in your app
    }
  }
}
