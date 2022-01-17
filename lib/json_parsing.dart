import 'dart:convert';

import 'package:http/http.dart' as http;

class ParseJSON {
  final int id;
  final String message;

  ParseJSON({required this.id, required this.message});

  factory ParseJSON.fromJson(Map<String, dynamic> json) {
    return ParseJSON(id: json['id'], message: json['title']);
  }
}

Future<ParseJSON> parse() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
  if (response.statusCode == 200) {
    return ParseJSON.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Json not responsed.');
  }
}
