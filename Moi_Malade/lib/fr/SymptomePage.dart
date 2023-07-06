import 'package:flutter/material.dart';
import 'package:moi_malade/widget/appbar.dart';
import 'package:moi_malade/widget/background.dart';
import 'package:moi_malade/widget/continueboutton.dart';
import 'package:moi_malade/widget/datatable.dart';
import 'package:moi_malade/widget/slider.dart';
import 'package:moi_malade/widget/symptomsearchbar.dart';
import '../Model/Symptom.dart';
import 'ResultPage.dart';
import '../network/api.dart';
import 'package:provider/provider.dart';
import '../widget/LanguageState.dart';

class SymptomePage extends StatefulWidget {
  final int age;
  final bool sexe;
  final String? ethnicite;

  SymptomePage({required this.age, required this.sexe, String? etnicite, required this.ethnicite});

  @override
  _SymptomePageState createState() => _SymptomePageState();
}

class _SymptomePageState extends State<SymptomePage> {
  double _currentSliderValue = 0;
  TextEditingController _searchController = TextEditingController();
  late Future<List<Symptom>> symptomsListFuture;
  late List<Symptom> symptomsList;
  late Api apiInstance;
  Symptom? _selectedSymptom;
  List<Map<String, dynamic>> _symptomsAndVelocity = [];


  @override
  void initState() {
    super.initState();
    apiInstance = Api();
    symptomsListFuture = loadSymptoms();
  }

  Future<List<Symptom>> loadSymptoms() async {
    var value = await apiInstance.getSymptoms();
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Symptom>>(
      future: symptomsListFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Symptom>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Stack(
              children: [
                Background(title: 'Symptômes :', titleENG: 'Symptoms :',),
                WhiteBox(
                  children: [],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<LanguageState>(
                          builder: (context, languageState, child) {
                            return Text(
                              languageState.isEnglish ? 'Loading...' : 'Chargement en cours...',
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Stack(
              children: [
                Background(title: 'Symptômes :', titleENG: 'Symptoms :',),
                WhiteBox(
                  children: [],
                  child: Center(
                    child: Consumer<LanguageState>(
                      builder: (context, languageState, child) {
                        return Text(
                          languageState.isEnglish ? 'Error: ${snapshot.error}' : 'Erreur: ${snapshot.error}',
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          symptomsList = snapshot.data!;
          return Scaffold(
            body: Stack(
              children: [
                Background(title: 'Symptoms :', titleENG: 'Symptômes :',),
                Builder(
                    builder: (context) {
                      return SingleChildScrollView(
                        child: WhiteBox(
                          children: [],
                          child: Padding( // Ajoutez ce widget
                            padding: EdgeInsets.symmetric(horizontal: 20.0), // 10 px d'espace à gauche et à droite
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Consumer<LanguageState>(
                                  builder: (context, languageState, child) {
                                    return Text(
                                      languageState.isEnglish ? 'What are your symptoms?' : 'Quels sont vos symptômes?',
                                      style: TextStyle(fontSize: 24),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                SymptomSearchWidget(
                                  symptomsList: symptomsList,
                                  onSelected: (Symptom selection) {
                                    setState(() {
                                      _selectedSymptom = selection;
                                      _searchController.text = selection.nomFr.toString();
                                    });
                                  },
                                  searchController: _searchController,
                                ),
                                SizedBox(height: 20),
                                Consumer<LanguageState>(
                                  builder: (context, languageState, child) {
                                    return Text(
                                      languageState.isEnglish ? 'Symptom velocity:' : 'Vélocité du symptôme:',
                                      style: TextStyle(fontSize: 24),
                                    );
                                  },
                                ),
                                SizedBox(height: 10),
                                Text(_currentSliderValue.toInt().toString(), style: TextStyle(fontSize: 24)),
                                VelocitySliderWidget(
                                  currentSliderValue: _currentSliderValue,
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                    });
                                  },
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFD7D0FF),
                                  ),
                                  onPressed: (_searchController.text.isEmpty || _symptomsAndVelocity.any((item) => item['symptom'] == _selectedSymptom)) ? null : () {
                                    setState(() {
                                      _symptomsAndVelocity.add({
                                        'symptom': _selectedSymptom,
                                        'velocity': _currentSliderValue.toInt(),
                                      });
                                      _searchController.clear();
                                      _currentSliderValue = 0;
                                    });
                                  },
                                  child: Consumer<LanguageState>(
                                    builder: (context, languageState, child) {
                                      return Text(
                                          languageState.isEnglish ? 'Add Symptoms and Velocity' : 'Ajouter Symptômes et Vélocité'
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 10),
                                SymptomDataTableWidget(
                                  symptomsAndVelocity: _symptomsAndVelocity,
                                  onRowDeleted: (Map<String, dynamic> item) {
                                    setState(() {
                                      _symptomsAndVelocity.remove(item);
                                    });
                                  },
                                ),
                                SizedBox(height:40),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),

                if(MediaQuery.of(context).viewInsets.bottom == 0)
                  Positioned(
                    bottom: 30,
                    left: 50,
                    right: 50,
                    child: ContinueButton(
                      onPressed: () async {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultatPage(
                              age: widget.age,
                              sexe: widget.sexe,
                              ethnicite: widget.ethnicite,
                              symptomsAndVelocity: _symptomsAndVelocity,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}