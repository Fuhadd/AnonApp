// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../../models/message.dart';
import '../local_cache/local_cache.dart';

abstract class ChatRepository {
  Future<void> sendMessage(String receiverId, String message);
  Stream<QuerySnapshot> getMessage(String currentUserId, String partnerUserId);
}

class ChatRepositoryImpl implements ChatRepository {
  late LocalCache cache;

  ChatRepositoryImpl({
    required this.cache,
  }) : super();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection('UserData');
  CollectionReference chatFirebaseFirestore =
      FirebaseFirestore.instance.collection('Chats');

  @override
  Future<void> sendMessage(String receiverId, String message) async {
    //Get Current User Information
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // Create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    //Construct chat room Id from users Id and receiver id to ensure uniqueness.
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    //add new message to database
    await chatFirebaseFirestore
        .doc('ChatRooms')
        .collection('messages')
        .add(newMessage.toJson());
  }

  @override
  Stream<QuerySnapshot> getMessage(String currentUserId, String partnerUserId) {
    // construct chat room from Id of user
    List<String> ids = [currentUserId, partnerUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return chatFirebaseFirestore
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
