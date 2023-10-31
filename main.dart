import 'package:flutter/material.dart';
import 'package:swifttalk/pages/login_page.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

void main() {
  ZIMKit().init(
    appID: 1701879901,
    appSign: 'cd675790f5e8afa104b34f98f1a42f180e9e046fa6aae68c52c96ccc2dd68908',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
