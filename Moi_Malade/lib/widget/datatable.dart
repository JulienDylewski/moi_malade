import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Symptom.dart';
import 'LanguageState.dart';
class SymptomDataTableWidget extends StatelessWidget {
  final List<Map<String, dynamic>> _symptomsAndVelocity;
  final Function(Map<String, dynamic>) onRowDeleted;
  final int maxVisibleItems = 4;

  SymptomDataTableWidget({
    required List<Map<String, dynamic>> symptomsAndVelocity,
    required Function(Map<String, dynamic>) onRowDeleted,
  })  : _symptomsAndVelocity = symptomsAndVelocity,
        onRowDeleted = onRowDeleted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxVisibleItems * 75.0, // 60.0 is an estimated height for each item
      child: ListView.builder(
        itemCount: _symptomsAndVelocity.length,
        itemBuilder: (context, index) {
          var isEnglish = Provider.of<LanguageState>(context, listen: false).isEnglish;
          var symptom = _symptomsAndVelocity[index]['symptom'] as Symptom;
          return Card(
            child: ListTile(
              leading: Text(symptom.id.toString()),
              title: Text(isEnglish ? symptom.nomEn : symptom.nomFr),
              subtitle: Text('Vélocité: ' + _symptomsAndVelocity[index]['velocity'].toString()),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  onRowDeleted(_symptomsAndVelocity[index]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}