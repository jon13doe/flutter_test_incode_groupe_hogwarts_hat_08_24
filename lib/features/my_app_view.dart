import 'package:flutter/material.dart';
import 'package:flutter_test_incode_groupe_hogwarts_hat_08_24/features/screens/home_screen.dart';

import 'screens/list_screen.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text([
          'Home Screen',
          'List Screen',
        ][_selectedIndex]),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Reset'),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: List.generate(3, (index) {
              return const SizedBox(
                child: Column(
                  children: [
                    Text('dfgdf'),
                    Text('dfgdf'),
                  ],
                ),
              );
            }),
          ),
          _selectedIndex == 0 ? const HomeScreen() : const ListScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
