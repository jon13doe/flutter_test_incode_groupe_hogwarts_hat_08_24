import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> houses = [
    'Gryffindor',
    'Slytherin',
    'Ravenclaw',
    'Hufflepuff'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.25 * MediaQuery.of(context).size.width, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 0.2 * MediaQuery.of(context).size.height,
            width: 0.3 * MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text('Image.network(' ')'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: const Text(
              'Harry',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: 4, // Added itemCount to limit the number of items
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 25,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Image.asset('assets/${houses[index]}.png'),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(houses[index]),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            height: 0.1 * MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                'Not in House',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
