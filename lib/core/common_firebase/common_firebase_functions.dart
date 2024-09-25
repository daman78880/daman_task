import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daman_task/core/common_constants/common_strings.dart';
import 'package:daman_task/core/snackbar/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../features/home/model/save_data_model.dart';
import '../routes/routes.dart';
import '../storage/local_storage.dart';

class CommonFirebaseFunctions {
  CommonFirebaseFunctions._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Static method for login or register using email and password
  static Future<User?> loginOrRegisterWithEmailPassword(
      String email, String password) async {
    try {
      // Try to sign in with Firebase Auth
      print('Attempting to log in with email: $email');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the logged-in user
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('User not found. Attempting to register.');
        // If user is not found, register them
        try {
          UserCredential userCredential =
              await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          print('User registered successfully.');
          return userCredential.user; // Return the newly registered user
        } on FirebaseAuthException catch (registerError) {
          // Handle registration errors
          print('Registration failed: ${registerError.message}');
          snackbar(registerError.message ?? CommonErrorMsg.str.tr);
          return null;
        }
      } else if (e.code == 'wrong-password') {
        // If the password is wrong for an existing user
        print('Wrong password provided.');
        snackbar('Incorrect password. Please try again.');
        return null;
      } else {
        // Handle other FirebaseAuth errors
        print('Firebase Auth Error: ${e.message}');
        snackbar(e.message ?? CommonErrorMsg.str.tr);
        return null;
      }
    } catch (e) {
      // Handle any other errors
      print('Unknown Error: $e');
      snackbar(e.toString() ?? CommonErrorMsg.str.tr);
      return null;
    }
  }

  static Future<String> currentId() async {
    String? id = _auth.currentUser?.uid;
    if (id == null) {
      snackbar(CommonErrorMsg.str.tr);
      Get.offAllNamed(Routes.loginScreen);
    }
    return id ?? '${Random.secure().nextInt(100)}';
  }

  static Future<void> logOutUser() async {
    await Prefs.erase();
    await FirebaseAuth.instance.signOut();
  }

  // Function to upload an image to Firebase Storage under 'daman' folder
  static Future<String?> uploadImageToFirebase(String imagePath) async {
    try {
      String id = await currentId();
      File file = File(imagePath);
      if (!file.existsSync()) {
        snackbar('File does not exist at the given path.');
        return null;
      }
      // Define the Firebase Storage reference for the 'daman' folder
      String fileName = imagePath.split('/').last; // Get file name from path
      Reference ref = _storage.ref().child('$id/$fileName');
      // Upload the file
      UploadTask uploadTask = ref.putFile(file);
      // Await the completion of the upload and get the download URL
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Image uploaded successfully. Download URL: $downloadUrl');
      return downloadUrl; // Return the download URL of the uploaded image
    } catch (e) {
      print('Image upload failed: $e');
      snackbar('Image upload failed: $e');
      return null;
    }
  }

  // Function to add image URLs to Firestore for a user in 'Daman' collection
  static Future<void> addImagesToFirestore(
      String recordName, List<String> imageUrls) async {
    try {
      String? currentUserId = _auth.currentUser?.uid;
      if (currentUserId == null) {
        snackbar('User is not logged in.');
        Get.offAllNamed(Routes.loginScreen);
        return;
      }
      var damanDocRef = _firestore.collection('Data').doc(recordName).set(
            SaveDataModel(userId: currentUserId, imageUrls: imageUrls,recordName: recordName).toJson(),
            SetOptions(merge: true),
          );
      snackbar('Images saved successfully to Firestore.');
    } catch (e) {
      print('Failed to add images to Firestore: $e');
      snackbar('Failed to add images to Firestore: $e');
    }
  }

  static Stream<List<SaveDataModel>> getDataList() async* {
    String? currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) {
      snackbar('User is not logged in.');
      Get.offAllNamed(Routes.loginScreen);
      return;
    }
    await for (QuerySnapshot snap in _firestore
        .collection('Data')
        .where('user_id', isEqualTo: currentUserId)
        // .orderBy('createdAt', descending: true)
        .snapshots()) {
          print('snap data ${snap.docs.first.data()}');
          print('snap data ${snap.docChanges?.first}');
      if (snap.docs.isNotEmpty) {
        try {

          List<SaveDataModel> listOfData = snap.docs
              .map(
                (e) => SaveDataModel.fromJson(e.data() as Map<String, dynamic>),
              )
              .toList();
          // SaveDataModel.fromJson(e),).toList();
          print('list of data is ${listOfData.length}');
          yield listOfData;
        } catch (e) {
          print(e);
          yield [];
        }
      } else {
        yield [];
      }
    }
  }

  static Future<SaveDataModel?> getDataByDocumentId(String documentId) async {
    String? currentUserId = _auth.currentUser?.uid;
    if (currentUserId == null) {
      snackbar('User is not logged in.');
      Get.offAllNamed(Routes.loginScreen);
      return null;
    }

    try {
      // Fetch the document by documentId from the Firestore collection 'Data'
      DocumentSnapshot docSnapshot = await _firestore
          .collection('Data')
          .doc(documentId)
          .get();

      // Check if the document exists
      if (docSnapshot.exists) {
        // Convert the document's data to a SaveDataModel
        SaveDataModel data = SaveDataModel.fromJson(
            docSnapshot.data() as Map<String, dynamic>);
        print('Data retrieved: ${data.toString()}');
        return data; // Return the model
      } else {
        print('No data found for documentId: $documentId');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      snackbar('Error fetching data.');
      return null;
    }
  }

}
