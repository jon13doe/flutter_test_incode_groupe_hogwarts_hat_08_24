import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/list_screen.dart';

class Harry extends StatefulWidget {
  const Harry({super.key});

  @override
  State<Harry> createState() => _HarryState();
}

class _HarryState extends State<Harry> {
  int _selectedIndex = 0;

  int total = 0;
  int success = 0;
  int failed = 0;
  Map<String, List<dynamic>> listOfAttemtChar = {};

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    success = await getSuccess();
    failed = await getFailed();
    setState(() {
      total = success + failed;
    });
  }

  Future<int> getSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('success') ?? 0;
  }

  Future<int> getFailed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('failed') ?? 0;
  }

  Future<void> resetValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('success', 0);
    await prefs.setInt('failed', 0);
    setState(() {
      total = 0;
      success = 0;
      failed = 0;
      listOfAttemtChar.clear();
    });
  }

  void updateOn() async {
    success = await getSuccess();
    failed = await getFailed();
    setState(() {
      total = success + failed;
    });
  }

  void updateListOfAttemtChar(Map<String, List<dynamic>> newListOfAttemtChar) {
    setState(() {
      listOfAttemtChar = newListOfAttemtChar;
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
            onPressed: () async {
              await resetValues();
              setState(() {
                total = 0;
                success = 0;
                failed = 0;
              });
            },
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
                      Text(
                        '${[total, success, failed][index]}',
                        style: const TextStyle(fontSize: 35),
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
            child: _selectedIndex == 0
                ? HomeScreen(
                    onChoose: updateOn, onUpdateList: updateListOfAttemtChar)
                : ListScreen(listOfAttemtChar: listOfAttemtChar),
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
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(
              fontFamily: 'HarryP',
            ),
          ),
        ),
        child: BottomNavigationBar(
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
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
