import 'package:flutter/material.dart';
import 'package:moi_malade/Model/Disease.dart';
import 'package:moi_malade/network/api.dart';
import 'package:provider/provider.dart';

import '../widget/LanguageState.dart';
import '../widget/background.dart';
import 'DetailMaladiePage.dart';  // Assurez-vous d'importer votre fichier api.dart

class ResultatPage extends StatefulWidget {
  final int age;
  final bool? sexe;
  final String? ethnicite;
  List<Map<String, dynamic>> symptomsAndVelocity ;

   ResultatPage({required this.age, required this.sexe, required this.ethnicite, required this.symptomsAndVelocity});
  @override
  _ResultatPageState createState() => _ResultatPageState();
}

class _ResultatPageState extends State<ResultatPage> {
  late Future<List<Disease>> futureDiseases;

  @override
  void initState() {
    super.initState();
    var api = Api(); // Initialisez l'instance d'Api ici
    String sexe = widget.sexe as bool ? 'male' : 'female';
    futureDiseases =
        api.getDiseases( // Utilisez l'instance d'Api pour appeler getDiseases
            age: widget.age,
            sex: sexe,
            ethnicity: widget.ethnicite.toString(),
            symptomsAndVelocity: widget.symptomsAndVelocity
        );
  }

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);

    return Scaffold(
      body: Stack(
        children: [
          Background(
            title: languageState.isEnglish ? 'Result' : 'Résultat :',
            titleENG: languageState.isEnglish ? 'Result' : 'Résultat :',
          ),
          WhiteBox(
            children: [],
            child: FutureBuilder<List<Disease>>(
              future: futureDiseases,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(languageState.isEnglish
                      ? "An error occurred"
                      : "Une erreur s'est produite");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  List<Disease>? diseases = snapshot.data;
                  return Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 50.0),
                              child: Text(
                                languageState.isEnglish
                                    ?
                                'Possible Causes\nWe found ${diseases
                                    ?.length} possible diseases related to your symptoms.'
                                    :
                                'Causes possibles\nNous avons trouvé ${diseases
                                    ?.length} maladies possibles liées à vos symptômes.',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 50),
                            DataTable(
                              columns: [
                                DataColumn(label: Text(languageState.isEnglish
                                    ? 'Score'
                                    : 'Score')),
                                DataColumn(label: Text(languageState.isEnglish
                                    ? 'Disease'
                                    : 'Maladie')),
                                DataColumn(label: Text('')),
                              ],
                              rows: diseases!.map((disease) {
                                return DataRow(cells: [
                                  DataCell(
                                      Text(disease.relevanceScore.toString())),
                                  DataCell(Text(
                                      languageState.isEnglish ? disease.name
                                          ?.nomEn ?? '' : disease.name?.nomFr ??
                                          '')),
                                  DataCell(
                                    Container(
                                      height: 50,
                                      width: 100,
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailMaladiePage(
                                                        disease: disease),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            languageState.isEnglish
                                                ? 'See details >'
                                                : 'Voir détail >',
                                            style: TextStyle(
                                                color: Color(0xFF6200EE)),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            side: BorderSide(
                                                color: Colors.transparent),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}