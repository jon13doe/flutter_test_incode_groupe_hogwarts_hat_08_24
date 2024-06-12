import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'data/api_url.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializePreferences();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

Future<void> initializePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (!prefs.containsKey('listOfChars')) {
    try {
      List<List<String>> listOfChars = await fetchListOfCharsFromApi();
      await prefs.setString('listOfChars', jsonEncode(listOfChars));
    } catch (e) {
      log('$e');
    }
  }
}

Future<List<List<String>>> fetchListOfCharsFromApi() async {
  final url = Uri.parse(harryAPI);

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> characters = jsonDecode(response.body);
      List<List<String>> listOfChars = [];

      for (var character in characters) {
        String name = character['name'] ?? '';
        String image = character['image'] ?? '';
        String house = character['house'] ?? '';
        String dateOfBirth = character['dateOfBirth'] ?? '';
        String actor = character['actor'] ?? '';
        String species = character['species'] ?? '';

        List<String> characterInfo = [
          name,
          image,
          house,
          dateOfBirth,
          actor,
          species
        ];
        listOfChars.add(characterInfo);
      }

      return listOfChars;
    } else {
      throw 'Failed to load characters: ${response.statusCode}';
    }
  } catch (e) {
    throw 'Failed to load characters: $e';
  }
}
