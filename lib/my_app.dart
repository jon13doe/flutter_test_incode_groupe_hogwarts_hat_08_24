import 'package:flutter/material.dart';

import 'features/my_app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'HarryP',
            fontSize: 16.0,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'HarryP',
            fontSize: 45.0,
            color: Colors.black,
          ),
        ),
      ),
      home: const MyAppView(),
    );
  }
}
