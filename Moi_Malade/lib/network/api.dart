import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Model/Symptom.dart';
import '../Model/Disease.dart';

class Api {
  final String _url = "http://192.168.1.60:8080/api";
  final String _header = "3cfa26d6-5c52-480b-90ea-7aee7b40a5d6";

  Future<List<Symptom>> getSymptoms() async {
    final response = await http.get(
        Uri.parse("$_url/symptoms"),
        headers: {'X-API-KEY': '$_header'}
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> embedded = data['_embedded'];
      List<dynamic> symptomsList = embedded['symptomsList'];

      return symptomsList.map((item) => Symptom.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load symptoms');
    }
  }

  Future<List<Disease>> getDiseases({
    required int age,
    required String sex,
    required String ethnicity,
    required List<Map<String, dynamic>> symptomsAndVelocity,
  }) async {

    List<List> symptomsList = symptomsAndVelocity.map((item) =>
    [item['symptom'].id, item['velocity']]
    ).toList();
    var symptomsAndVelocityJson = jsonEncode(symptomsAndVelocity.map((item) => [item['symptom'].id, item['velocity']]).toList());
    var symptomsAndVelocityEncoded = Uri.encodeComponent(symptomsAndVelocityJson);

    final response = await http.get(
        Uri.parse("$_url/search?sex=$sex&age=$age&ethnicity=$ethnicity&symptoms=$symptomsAndVelocityEncoded"),
        headers: {'X-API-KEY': '$_header'}
    );
    print('GET Request: ${response.request?.url}');
    print(sex);
    print(symptomsAndVelocityJson);
    print(symptomsAndVelocityEncoded);

    if (response.statusCode == 200) {
      String bodyUtf8 = utf8.decode(response.bodyBytes);  // Force le décodage en UTF-8
      List<dynamic> data = jsonDecode(bodyUtf8);
      print(' ${bodyUtf8}');
      return data.map((item) => Disease.fromJson(item)).toList();
    } else {
      print('Error: ${response.body}');
      throw Exception('Failed to load diseases');
    }
  }
}
