import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(''),
        const Text('sdfsdf'),
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              child: Column(
                children: [
                  Image.network(''),
                  Text([
                    'Gryffindor',
                    'Slytherin',
                    'Ravenclaw',
                    'Hufflepuff'
                  ][index]),
                ],
              ),
            );
          },
        ),
        const SizedBox(
          child: Text('Not in House'),
        ),
      ],
    );
  }
}
