import 'dart:convert';

import 'package:flutter/services.dart';
class Maladie {
  final int id;
  final String nomFr;
  final String nomEn;


  Maladie({
    required this.id,
    required this.nomFr,
    required this.nomEn,
  });

  factory Maladie.fromJson(Map<String, dynamic> json) {
    return Maladie(
      id: json['id'] as int,
      nomFr: json['nomFr'] as String,
      nomEn: json['nomEn'] as String,
    );
  }
}
