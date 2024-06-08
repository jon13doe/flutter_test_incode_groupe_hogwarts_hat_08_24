import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          width: 15,
          height: 15,
          child: TextField(),
        ),
        SizedBox(
          width: 15,
          height: 150,
          child: CustomScrollView(
            slivers: List.generate(4, (index) {
              return Row(
                children: [
                  Image.network(''),
                  Column(
                    children: [
                      Text(''),
                      Text('Attempts: '),
                    ],
                  ),
                  Icon(Icons.circle),
                  Icon(Icons.check),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
