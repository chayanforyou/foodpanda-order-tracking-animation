import 'package:flutter/material.dart';

import 'view/order_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorSchemeSeed: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        splashFactory: InkSplash.splashFactory,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
      ),
      home: const OrderPage(),
    );
  }
}
