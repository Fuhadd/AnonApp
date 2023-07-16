// import 'package:anon/data/repositories/chat_repo.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../locator.dart';

// class ChatPage extends StatefulWidget {
//   final String receiverUserEmail;
//   final String receiverUserId;

//   const ChatPage({
//     super.key,
//     required this.receiverUserEmail,
//     required this.receiverUserId,
//   });

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatRepository _chatRepository = ChatRepository ?? locator();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   void sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       await _chatRepository.sendMessage(
//           widget.receiverUserId, _messageController.text);
//       //clear the text container after sending the message
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Expanded(
//             child: _buildMessageList(),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   //build message List

//   Widget _buildMessageList() {
//     return StreamBuilder(
//         stream: _chatRepository.getMessage(
//             widget.receiverUserId, _firebaseAuth.currentUser!.uid),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error${snapshot.error}');
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           }
//           return ListView(
//             children: snapshot.data!.docs
//                 .map((document) => _buildMessageItem(document))
//                 .toList(),
//           );
//         });
//   }

//   //build message Item
//   Widget _buildMessageItem(DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data() as Map<String, dynamic>;

//     //align the message to
//     var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
//         ? Alignment.centerRight
//         : Alignment.centerLeft;

//     return Container(
//       alignment: alignment,
//       child: Column(
//         children: [
//           Text(data['senderEmail']),
//           Text(data['message']),
//         ],
//       ),
//     );
//   }

//   //build message Input
//   Widget _buildMessageInput() {
//     return Row(
//       children: [
//         Expanded(
//             child: TextField(
//           controller: _messageController,
//         )),
//         IconButton(
//           onPressed: sendMessage,
//           icon: const Icon(
//             Icons.arrow_upward,
//             size: 40,
//           ),
//         ),
//       ],
//     );
//   }
// }
