import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  static Message fromJson(json) => Message(
      senderId: json['senderId'],
      senderEmail: json['senderEmail'],
      receiverId: json['receiverId'],
      message: json['message'],
      timestamp: json['timestamp']);

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "senderEmail": senderEmail,
        "receiverId": receiverId,
        "message": message,
        "timestamp": timestamp,
      };
}
