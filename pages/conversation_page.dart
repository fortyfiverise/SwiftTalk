import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swifttalk/components/toast.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

Widget conversationPage(BuildContext context, ZIMKitConversation conversation) {
  return ZIMKitMessageListPage(
    conversationID: conversation.id,
    conversationType: conversation.type,
    messageListBackgroundBuilder: (context, defaultWidget) {
      return const ColoredBox(
        color: Color(0xFFEEEBE6),
      );
    },
    messageItemBuilder: (context, message, defaultWidget) {
      return Theme(
        data: ThemeData(
          primaryColor: const Color(0xFF41624F),
        ),
        child: defaultWidget,
      );
    },
    appBarBuilder: (context, defaultAppBar) {
      return AppBar(
        backgroundColor: const Color(0xFF41624F),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF41624F),
              child: conversation.icon,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(conversation.name,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.clip),
                Text(conversation.id,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.clip)
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: conversation.id)).then(
                (_) {
                  showToast('Copied to clipboard:${conversation.id}');
                },
              );
            },
          ),
        ],
      );
    },
    inputBackgroundDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: const Color.fromARGB(60, 65, 98, 79),
    ),
    inputDecoration: const InputDecoration(
        border: InputBorder.none, hintText: 'Type your message here'),
    showPickFileButton: false,
    showPickMediaButton: true,
  );
}