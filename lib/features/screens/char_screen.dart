import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Row(
        children: [
          Image.network(''),
          const Column(
            children: [
              Text('House: '),
              Text('Date of birth: '),
              Text('Actor: '),
              Text('Species: '),
            ],
          ),
        ],
      ),
    );
  }
}
