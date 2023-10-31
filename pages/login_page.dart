import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swifttalk/pages/messages_page.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userId = TextEditingController();
  final userName = TextEditingController();
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedUserData();
  }

  void _loadSavedUserData() async {
    await SharedPreferences.getInstance().then((prefs) {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      if (rememberMe) {
        setState(() {
          userId.text = prefs.getString('userId') ?? '';
          userName.text = prefs.getString('userName') ?? '';
          rememberMe = prefs.getBool('rememberMe') ?? false;
        });
      }
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 83, 83, 83),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _loginMethod(String userId, String userName) async {
    if (userId.isNotEmpty && userName.isNotEmpty) {
      try {
        await ZIMKit().connectUser(id: userId.trim(), name: userName.trim());
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return MessagesPage();
        }));
        if (rememberMe) {
          _saveUserData();
        }
      } catch (e) {
        _showToast("Server: Error logging in");
      }
    } else {
      _showToast("Please complete all fields");
    }
  }

  void _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId.text);
    prefs.setString('userName', userName.text);
    prefs.setBool('rememberMe', rememberMe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEBE6),
      body: Center(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "SwiftTalk",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF41624F),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: userName,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF41624F), width: 2),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF41624F),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: userId,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF41624F), width: 2),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Color(0xFF41624F),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: const Color(0xFF41624F),
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                        shape: const CircleBorder(),
                      ),
                      const Text("Remember me"),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        _loginMethod(userId.text, userName.text);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF41624F)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 32.0),
                        child: Text(
                          'Sign In',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
