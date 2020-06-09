import 'package:flutter/material.dart';

import 'package:saipaapp/ui/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سایپا',
      initialRoute: '/',
      routes: {
        '/': (ctx) => LoginScreen(),
      },
    );
  }
}
