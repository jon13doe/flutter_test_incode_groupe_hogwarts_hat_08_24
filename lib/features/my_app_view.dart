import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'screens/home_screen.dart';
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
        centerTitle: true,
        title: Text([
          'Home Screen',
          'List Screen',
        ][_selectedIndex]),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Reset',
              style: TextStyle(
                fontFamily: 'HarryP',
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: 0.9 * MediaQuery.of(context).size.width,
            child: const Divider(
              height: 1,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) {
                return Container(
                  height: 0.1 * MediaQuery.of(context).size.height,
                  width: 0.2 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        '888',
                        style: TextStyle(fontSize: 35),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(['Total', 'Succes', 'Failed'][index])),
                    ],
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child:
                _selectedIndex == 0 ? const HomeScreen() : const ListScreen(),
          ),
          SizedBox(
            width: 0.9 * MediaQuery.of(context).size.width,
            child: const Divider(
              height: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 20,
        selectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home.png',
              height: 0.5 * kToolbarHeight,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/foliant.png',
              height: 0.5 * kToolbarHeight,
            ),
            label: 'List',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
