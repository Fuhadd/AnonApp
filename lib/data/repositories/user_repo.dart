// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../../locator.dart';
import '../../models/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../local_cache/local_cache.dart';

abstract class UserRepository {
  Future<User?> createUserWithEmail(String email, String password);
  Future<User?> loginWithEmail(String email, String password);
  Future isUserSignedIn();
  Future logOut();
  Future resetPassword(String email);
  Future<AppUser> fetchCurrentUser();
  Future<String?> saveUserCredentials(
      String email, String userName, String avatarUrl, DateTime accountCreated);
  Future<AppUser?> getUsersCredentials();
  // Stream<QuerySnapshot<Object?>>? getAllConfessions();
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getAllConfessions();

  Future<bool?> sendConfession(
      {required String message,
      required String destinationName,
      required String destinationId,
      required String destinationImage});

  Stream<QuerySnapshot> getAllConfessionStream();
  Stream<QuerySnapshot> getAllReadConfessionStream();
  Stream<QuerySnapshot> getAllUnreadConfessionStream();
  Future<bool?> readConfession({
    required String confessionId,
  });
  //  Future<GenericResponse> getUsersForMatching(int pageNumber, int pageSize);
}

class UserRepositoryImpl implements UserRepository {
  late LocalCache cache;

  UserRepositoryImpl({
    required this.cache,
  }) : super();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('UserData');
  CollectionReference confessionsFirebaseFirestore =
      FirebaseFirestore.instance.collection('Confessions');

  @override
  Future<User?> createUserWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      if (user != null) {
        return user;
      } else {
        return null;
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An Error Occures';
      switch (error.code) {
        case 'invalid-email:':
          message = 'Email is Invalid!';
          break;
        case 'email-already-in-use:':
          message =
              'The email address already exists.Please proceed to login Screen ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
      print(message);
    }
  }

  @override
  Future<AppUser> fetchCurrentUser() async {
    throw UnimplementedError();
    //  try {
    //   String? userJson = await SharedPreferenceHelper().getcurrentUser();
    //   AppUser currentUser = AppUser.fromJson(json.decode(userJson!));
    //   return currentUser;
    // } on PlatformException catch (error) {
    //   throw Exception(error);
    // }
  }

  @override
  Future isUserSignedIn() async {
    User? user = firebaseAuth.currentUser;
    return user != null && user.uid.isNotEmpty;
  }

  @override
  Future logOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<User?> loginWithEmail(String email, String password) async {
    try {
      UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        return user;
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error has occured.'; // default message
      switch (error.code) {
        case 'user-disabled':
          message =
              'This user has been temporarily disabled, Contact Support for more information';
          break;
        case 'user-not-found':
          message =
              'The email address is not assocciated with a user.Try another Email up or Register with this email address ';
          break;
        case 'wrong-password':
          message = 'Invalid password. Please enter correct password.';
          break;
      }
      throw Exception(message);
    }
    return null;
  }

  @override
  Future resetPassword(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<String?> saveUserCredentials(String email, String userName,
      String avatarUrl, DateTime accountCreated) async {
    String? uid = firebaseAuth.currentUser?.uid.toString();

    await firebaseFirestore.doc(uid.toString()).set(
        {
          'id': uid.toString(),
          'email': email,
          'userName': userName,
          'accountCreated': accountCreated,
          'avatarUrl': avatarUrl,
          'myposts': [],
          'pastConfessors': []
        },
        SetOptions(
          merge: true,
        ));
    return uid;
  }

  @override
  Future<AppUser?> getUsersCredentials() async {
    try {
      String uid = firebaseAuth.currentUser!.uid;

      final appUser = firebaseFirestore.doc(uid);
      final snapshot = await appUser.get();

      if (snapshot.exists) {
        return AppUser.fromJson(snapshot.data());
      }
    } catch (error) {}
    return null;
  }

  @override
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getAllConfessions() async {
    String uid = firebaseAuth.currentUser!.uid;

    final confessions = firebaseFirestore.doc(uid).collection("confessions");
    final snapshot = await confessions.get();
    return snapshot.docs;
  }

  @override
  Stream<QuerySnapshot> getAllConfessionStream() {
    // construct chat room from Id of user
    String uid = firebaseAuth.currentUser!.uid;
    final confessions =
        confessionsFirebaseFirestore.where('destinationId', isEqualTo: uid);
    // final confessions = firebaseFirestore.doc(uid).collection("confessions");
    return confessions.snapshots();

    // return chatFirebaseFirestore
    //     .doc(chatRoomId)
    //     .collection('messages')
    //     .orderBy('timestamp', descending: false)
    //     .snapshots();
  }

  @override
  Future<bool?> sendConfession(
      {required String message,
      required String destinationName,
      required String destinationId,
      required String destinationImage}) async {
    try {
      String? uid = firebaseAuth.currentUser?.uid.toString();
      final docUser = confessionsFirebaseFirestore.doc();
      final userData = locator<LocalCache>().getUserData();
      await docUser.set(
          {
            "id": docUser.id,
            "imageUrl": userData.avatarUrl,
            "userName": userData.userName,
            "title": "Send me a message",
            "content": message,
            "destinationName": destinationName,
            "destinationId": destinationId,
            "destinationImage": destinationImage,
            "read": 0,
            "createdAt": Timestamp.now(),
          },
          SetOptions(
            merge: true,
          ));
      if (uid != null) {
        Map<String, dynamic> pastConfessorMap = {
          "id": destinationId,
          "name": destinationName,
        };
        await firebaseFirestore.doc(uid.toString()).update(
          {
            'pastConfessors': FieldValue.arrayUnion([pastConfessorMap]),
          },
        );
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool?> readConfession({
    required String confessionId,
  }) async {
    try {
      await confessionsFirebaseFirestore.doc(confessionId).update(
        {
          'read': 1,
        },
      );

      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getAllReadConfessionStream() {
    String uid = firebaseAuth.currentUser!.uid;
    final confessions = confessionsFirebaseFirestore
        .where('destinationId', isEqualTo: uid)
        .where('read', isEqualTo: 1);
    return confessions.snapshots();
  }

  @override
  Stream<QuerySnapshot<Object?>> getAllUnreadConfessionStream() {
    String uid = firebaseAuth.currentUser!.uid;
    final confessions = confessionsFirebaseFirestore
        .where('destinationId', isEqualTo: uid)
        .where('read', isEqualTo: 0);
    return confessions.snapshots();
  }
}
