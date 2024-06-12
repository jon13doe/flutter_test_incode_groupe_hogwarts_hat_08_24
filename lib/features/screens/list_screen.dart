import 'package:flutter/material.dart';
import 'package:flutter_test_incode_groupe_hogwarts_hat_08_24/features/screens/char_screen.dart';
import 'home_screen.dart';

class ListScreen extends StatefulWidget {
  final Map<String, List<dynamic>> listOfAttemtChar;

  const ListScreen({
    super.key,
    required this.listOfAttemtChar,
  });

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<List<dynamic>> _originalList = [];
  List<List<dynamic>> _filteredList = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _originalList = getProcessedList();
    _filteredList = List.from(_originalList);
    _searchController.addListener(_filterList);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterList);
    _searchController.dispose();
    super.dispose();
  }

  List<List<dynamic>> getProcessedList() {
    List<List<dynamic>> processedList = [];
    widget.listOfAttemtChar.forEach((key, value) {
      List<dynamic> newList = List.from(value)..add(key);
      processedList.add(newList);
    });
    return processedList;
  }

  void _filterList() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredList = _originalList.where((item) {
        String lastElement = item.last.toString().toLowerCase();
        return lastElement.contains(query);
      }).toList();
    });
  }

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
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CharScreen(
                                char: _filteredList[index],
                              );
                            }),
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: 0.1 * MediaQuery.of(context).size.height,
                              width: 0.1 * MediaQuery.of(context).size.width,
                              child: CharIcon(
                                imgUrl: _filteredList[index][0],
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_filteredList[index].last as String),
                                Text('Attempts: ${_filteredList[index][6]}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      !_filteredList[index][5]
                          ? IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.autorenew),
                            )
                          : const SizedBox(),
                      const SizedBox(width: 5),
                      !_filteredList[index][5]
                          ? const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.check_circle_outline_rounded,
                              color: Colors.green,
                            ),
                    ],
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
