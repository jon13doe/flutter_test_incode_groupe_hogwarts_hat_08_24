import 'package:flutter/material.dart';
import 'package:flutter_test_incode_groupe_hogwarts_hat_08_24/features/screens/char_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 10,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              height: kToolbarHeight,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const CharScreen(
                        guessed: true,
                      );
                    }));
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Image.network(
                            'https://via.placeholder.com/50'), // Placeholder image
                        const SizedBox(width: 10), // Add some spacing
                        const Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start, // Align to the start
                          children: [
                            Text('qwe'),
                            Text('Attempts: '),
                          ],
                        ),
                        const Spacer(), // Push the icons to the right end
                        const Icon(Icons.autorenew),
                        const SizedBox(width: 5), // Add some spacing
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.green,
                        ),
                        const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
