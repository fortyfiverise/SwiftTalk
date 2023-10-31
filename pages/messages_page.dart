import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swifttalk/components/toast.dart';
import 'package:swifttalk/pages/conversation_page.dart';
import 'package:swifttalk/pages/login_page.dart';
import 'package:swifttalk/components/dialogs.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({Key? key}) : super(key: key);
  final TextEditingController userIDController = TextEditingController();
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController groupIDController = TextEditingController();
  final TextEditingController membersController = TextEditingController();

  void _handleLogout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('rememberMe', false);
      ZIMKit().disconnectUser();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }));
    } catch (e) {
      showToast('An error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFEEEBE6),
        appBar: AppBar(
          backgroundColor: const Color(0xFF41624F),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _handleLogout(context);
            },
          ),
          title: const Center(child: Text("Messages")),
          actions: [
            IconButton(
              icon: const Icon(Icons.library_add_outlined),
              onPressed: () {
                chatOptionDialog(context);
              },
            ),
          ],
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return conversationPage(context, conversation);
              },
            ));
          },
        ),
      ),
    );
  }
}
