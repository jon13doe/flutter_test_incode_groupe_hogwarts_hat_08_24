import 'package:flutter/material.dart';

import 'home_screen.dart';

class CharScreen extends StatefulWidget {
  final List<dynamic> char;
  const CharScreen({super.key, required this.char});

  @override
  State<CharScreen> createState() => _CharScreenState();
}

class _CharScreenState extends State<CharScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Harry Potter'),
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
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 0.35 * MediaQuery.of(context).size.width,
                  child: CharIcon(
                    imgUrl: widget.char[0],
                    fontSize: 40,
                  ),
                ),
                widget.char[5]
                    ? SizedBox(
                        width: 0.4 * MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('House: ${widget.char[1]}'),
                              Text('Date of birth: ${widget.char[2]}'),
                              Text('Actor: ${widget.char[3]}'),
                              Text('Species: ${widget.char[4]}'),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: kToolbarHeight,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.red),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'ACCESS DENIED',
                            style: TextStyle(color: Colors.red, fontSize: 30),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
