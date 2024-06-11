import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onChoose;

  const HomeScreen({
    super.key,
    required this.onChoose,
  });

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

  List<List<String>> listOfChars = [];
  Random random = Random();
  int randPerson = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchListOfChars();
  }

  Future<void> fetchListOfChars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('listOfChars');
    if (jsonString != null) {
      List<dynamic> decoded = jsonDecode(jsonString);
      List<List<String>> characters = [];
      for (var character in decoded) {
        List<String> characterInfo = List<String>.from(character);
        characters.add(characterInfo);
      }
      setState(() {
        listOfChars = characters;
        randPerson = random.nextInt(listOfChars.length);
        isLoading = false;
      });
    }
  }

  Future<void> incrementSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int success = (prefs.getInt('success') ?? 0) + 1;
    await prefs.setInt('success', success);
    widget.onChoose();
  }

  Future<void> incrementFailed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int failed = (prefs.getInt('failed') ?? 0) + 1;
    await prefs.setInt('failed', failed);
    widget.onChoose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 0.25 * MediaQuery.of(context).size.width, vertical: 10),
      child: isLoading
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.black),
                Text('Loading...'),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 0.2 * MediaQuery.of(context).size.height,
                  width: 0.3 * MediaQuery.of(context).size.width,
                  child: Center(
                    child: listOfChars.isNotEmpty &&
                            randPerson < listOfChars.length &&
                            listOfChars[randPerson].isNotEmpty
                        ? Image.network(
                            listOfChars[randPerson][1],
                          )
                        : const Placeholder(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    listOfChars.isNotEmpty && randPerson < listOfChars.length
                        ? listOfChars[randPerson][0]
                        : 'No data available',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          if (houses[index] == listOfChars[randPerson][2]) {
                            incrementSuccess();
                          } else {
                            incrementFailed();
                          }
                          setState(() {
                            randPerson = random.nextInt(listOfChars.length);
                          });
                        },
                        splashColor: Colors.amberAccent,
                        child: Container(
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
                                child:
                                    Image.asset('assets/${houses[index]}.png'),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(houses[index]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!houses.contains(listOfChars[randPerson][2])) {
                      incrementSuccess();
                    } else {
                      incrementFailed();
                    }
                    setState(() {
                      randPerson = random.nextInt(listOfChars.length);
                    });
                  },
                  splashColor: Colors.amberAccent,
                  child: Container(
                    height: 0.1 * MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Text(
                        'Not in House',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
