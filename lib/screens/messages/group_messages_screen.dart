import 'package:flutter/material.dart';

import '../../widgets/message_container.dart';

class GroupMessagesScreen extends StatelessWidget {
  const GroupMessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const MessageContainer(
            isGroup: true,
          );
        });
  }
}
