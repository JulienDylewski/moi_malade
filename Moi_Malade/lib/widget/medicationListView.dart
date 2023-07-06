import 'package:flutter/material.dart';
import 'package:moi_malade/Model/Disease.dart';

class DiseaseMedicationsList extends StatelessWidget {
  final Disease disease;

  DiseaseMedicationsList({required this.disease});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: disease.medicationsList?.length,
      itemBuilder: (BuildContext context, int index) {
        String medication = disease.medicationsList?[index] as String;
        return ListTile(
          title: Text(medication),
        );
      },
    );
  }
}
