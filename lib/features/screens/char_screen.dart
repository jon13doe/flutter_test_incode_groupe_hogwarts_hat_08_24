import 'package:flutter/material.dart';

class CharScreen extends StatefulWidget {
  final bool guessed;
  const CharScreen({super.key, required this.guessed});

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
                Image.network('https://via.placeholder.com/150x200'),
                widget.guessed
                    ? SizedBox(
                        width: 0.4 * MediaQuery.of(context).size.width,
                        child: const Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('House: '),
                              Text('Date of birth: '),
                              Text('Actor: '),
                              Text('Species: '),
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
