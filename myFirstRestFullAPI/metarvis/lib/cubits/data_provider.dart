import 'package:metarvis/cubits/data/data.dart';
import 'package:dio/dio.dart';


class DataDataProvider {
  static Future<Data> fetch() async {
    try {
      final request = await http.get(Uri.parse('http://localhost:8080'));

      return Data.fromJson(request.body);
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}
