import 'package:flutter/material.dart';

import 'features/my_app_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAppView(),
    );
  }
}