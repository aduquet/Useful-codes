import 'dart:convert';
import 'package:example_api_fronted/counter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Prueba with ChangeNotifier {
  final url = 'http://127.0.0.1:8080/';
  final List<CounterItem> _items = [];

  Future<void> addTodo(String counter) async {
    if (counter.isEmpty) {
      return;
    }
    Map<String, dynamic> request = {"a": counter};
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(Uri.parse('$url/a'),
        headers: headers, body: json.encode(request));
    Map<String, dynamic> responsePayload = json.decode(response.body);
    final count = CounterItem(a: responsePayload["a"]);
    _items.add(count);
    notifyListeners();
  }
}
