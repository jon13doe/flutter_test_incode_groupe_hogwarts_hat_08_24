// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onChoose;
  final Function(Map<String, List<dynamic>>)? onUpdateList;

  const HomeScreen({
    super.key,
    this.onChoose,
    this.onUpdateList,
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
  Map<String, List<dynamic>> listOfAttemtChar = {};

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
    widget.onChoose!();
  }

  Future<void> incrementFailed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int failed = (prefs.getInt('failed') ?? 0) + 1;
    await prefs.setInt('failed', failed);
    widget.onChoose!();
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
                  child: CharIcon(
                    imgUrl: listOfChars[randPerson][1],
                    fontSize: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    listOfChars[randPerson][0],
                    style: const TextStyle(fontSize: 25),
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
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          bool guessed =
                              houses[index] == listOfChars[randPerson][2];
                          if (guessed) {
                            incrementSuccess();
                          } else {
                            incrementFailed();
                          }
                          if (!listOfAttemtChar
                              .containsKey(listOfChars[randPerson][0])) {
                            listOfAttemtChar[listOfChars[randPerson][0]] = [
                              listOfChars[randPerson][1],
                              listOfChars[randPerson][2],
                              listOfChars[randPerson][3],
                              listOfChars[randPerson][4],
                              listOfChars[randPerson][5],
                              guessed,
                              1,
                            ];
                          } else {
                            listOfAttemtChar[listOfChars[randPerson][0]]?[5] =
                                listOfAttemtChar[listOfChars[randPerson][0]]
                                            ?[5] ==
                                        false
                                    ? guessed
                                    : true;
                            listOfAttemtChar[listOfChars[randPerson][0]]?[6] +=
                                1;
                          }
                          widget.onUpdateList!(listOfAttemtChar);
                          setState(() {
                            randPerson = random.nextInt(listOfChars.length);
                          });
                        },
                        splashColor: Colors.amberAccent,
                        child: SizedBox(
                          height: 25,
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

class CharIcon extends StatelessWidget {
  final String imgUrl;
  final double fontSize;

  const CharIcon({
    super.key,
    required this.imgUrl,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: imgUrl != ''
          ? Image.network(
              imgUrl,
            )
          : Stack(
              alignment: Alignment.center,
              children: [
                Image.asset('assets/hat.png'),
                Transform.rotate(
                  angle: -pi / 6,
                  child: Text(
                    'No data',
                    style: TextStyle(
                      fontSize: fontSize,
                      color: Colors.grey,
                      shadows: List.generate(4, (index) {
                        return Shadow(
                            offset: Offset(index % 2 > 0 ? 1.5 : -1.5,
                                index % 2 > 0 ? -1.5 : 1.5),
                            color: Colors.black);
                      }),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
