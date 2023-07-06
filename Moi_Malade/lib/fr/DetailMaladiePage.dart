import 'package:flutter/material.dart';
import 'package:moi_malade/widget/appbar.dart';
import 'package:provider/provider.dart';
import '../Model/Disease.dart';
import '../widget/ExpandableButton.dart';
import '../widget/background.dart';
import '../widget/LanguageState.dart';
import '../widget/medicationListView.dart';

class DetailMaladiePage extends StatelessWidget {
  final Disease disease;

  DetailMaladiePage({required this.disease});

  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    String proceduresText = '';
    String medicationsList = '';
    //-----------------------------MedicationList--------------------------
    if (disease.medicationsList != null) {
      medicationsList = disease.medicationsList!
          .map((medicationsList) =>
      languageState.isEnglish
          ? medicationsList.nomEn ?? 'Procedure not available'
          : medicationsList.nomFr ?? 'Procédure non disponible')
          .join('\n');
    } else {
      medicationsList = languageState.isEnglish
          ? 'No medication list available.'
          : 'Aucune liste de médicament disponible.';
    }
    //--------------------------------testProce----------------------------------
    if (disease.testsProceduresList != null) {
      proceduresText = disease.testsProceduresList!
          .map((testProcedure) =>
      languageState.isEnglish
          ? testProcedure.nomEn ?? 'Procedure not available'
          : testProcedure.nomFr ?? 'Procédure non disponible')
          .join('\n');
    } else {
      proceduresText = languageState.isEnglish
          ? 'No testing procedure available.'
          : 'Aucune procédure de test disponible.';
    }

    return Scaffold(
      body: Stack(
        children: [
          Background(
            title: languageState.isEnglish ? 'Disease Details' : 'Détails de la maladie :',
            titleENG: languageState.isEnglish ? 'Disease Details' : 'Détails de la maladie :',
          ),
          WhiteBox(
            children: [],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    languageState.isEnglish
                        ? disease.name?.nomEn ?? 'Disease name not available'
                        : disease.name?.nomFr ?? 'Nom de la maladie non disponible',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [

                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD7D0FF),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    width: 50.0,
                                    height: 50.0,
                                    child: Image.asset('assets/images/image10.png'),
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        languageState.isEnglish
                                            ? disease.medicationDescription?.descriptionEn ?? 'Description not available'
                                            : disease.medicationDescription?.descriptionFr ?? 'Description non disponible',
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.visible,
                                      ))),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [

                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFBBD7),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                                    width: 50.0,
                                    height: 50.0,
                                    child: Image.asset('assets/images/image9.png'),
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        languageState.isEnglish
                                            ? disease.whois?.descEn ?? 'Risk group not available'
                                            : disease.whois?.descFr ?? 'Personne a risque non disponible',
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.visible,
                                      ))),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ExpandableButton(
                          buttonName: languageState.isEnglish ? 'Symptom description' : 'Symptômes description',
                          label: languageState.isEnglish
                              ? disease.symptomDescription?.nomEn ?? 'Description not available'
                              : disease.symptomDescription?.nomFr ?? 'Description non disponible',
                        ),
                        SizedBox(height: 10),
                        ExpandableButton(
                          buttonName: languageState.isEnglish ? 'Medications' : 'Médicaments',
                          label: medicationsList,
                        ),
                        SizedBox(height: 10),
                        ExpandableButton(
                          buttonName: languageState.isEnglish ? 'Medication description' : 'Médicament description',
                          label: languageState.isEnglish
                              ? disease.medicationDescription?.descriptionEn ?? 'Description not available'
                              : disease.medicationDescription?.descriptionFr ?? 'Description non disponible',
                        ),
                        SizedBox(height: 10),
                        ExpandableButton(
                          buttonName: languageState.isEnglish ? 'Tests and procedures' : 'Tests et procédures',
                          label: proceduresText,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
