import 'package:flutter/material.dart';
import 'package:moi_malade/widget/appbar.dart';
import 'package:moi_malade/widget/background.dart';
import 'package:moi_malade/widget/slider.dart';
import 'package:moi_malade/widget/continueboutton.dart';
import 'package:moi_malade/widget/genderbutton.dart';
import 'package:provider/provider.dart';
import '../widget/LanguageState.dart';
import './SymptomePage.dart';

class AgePage extends StatefulWidget {
  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int _age = 0;
  bool _isMale = false;
  String? _selectedEthnicity;

  Map<String, String> _ethnicityMap = {
    'white': 'white',
    'black': 'black',
    'mixed': 'métis',
    'african': 'africain',
    'african american': 'afro-américain',
    'latino american': 'latino-Américain',
    'indian': 'indien',
  };


  void _handleAgeChange(double age) {
    setState(() {
      _age = age.toInt();
    });
  }

  void _handleGenderChange(bool isMale) {
    setState(() {
      _isMale = isMale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(title: 'Informations :', titleENG: 'Informations :',),
          WhiteBox(
            children: [],
            child: Stack(
              children: [
                Positioned(
                  top:100,
                  left: 50,
                  right: 50,
                  child: AgeSlider(onAgeChange: _handleAgeChange),
                ),
                Positioned(
                  top:250,
                  left: 50,
                  right: 50,
                  child: Consumer<LanguageState>(
                    builder: (context, languageState, child) {
                      return Text(
                          languageState.isEnglish ? 'What is your sex ?'  : 'Quel est vôtre sexe ?',
                          style: TextStyle(fontSize: 24), textAlign: TextAlign.center,);
                    },
                  ),
                ),
                Positioned(
                  top:300,
                  left: 50,
                  right: 50,
                  child: GenderButtons(onGenderChange: _handleGenderChange),
                ),
                Positioned(
                  top:380,
                  left: 50,
                  right: 50,
                  child: Consumer<LanguageState>(
                    builder: (context, languageState, child) {
                      return Text(
                          languageState.isEnglish ?   'What is your ethnicity ?' : 'Quel est vôtre ethnicité ?',
                          style: TextStyle(fontSize: 24), textAlign: TextAlign.center, );
                    },
                  ),
                ),Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 200.0),
                    child: DropdownButton<String>(
                      value: _selectedEthnicity,
                      hint: Consumer<LanguageState>(
                        builder: (context, languageState, child) {
                          return Text(
                            languageState.isEnglish ? 'Ethnicity' : 'Ethnicité',
                          );
                        },
                      ),
                      items: _ethnicityMap.keys
                          .map<DropdownMenuItem<String>>((String key) {
                        return DropdownMenuItem<String>(
                          value: key,
                          child: Consumer<LanguageState>(
                            builder: (context, languageState, child) {
                              return Text(languageState.isEnglish ? key : _ethnicityMap[key]!);
                            },
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedEthnicity = newValue;
                        });
                      },
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => Positioned(
                    top: 550,
                    left: 50,
                    right: 50,
                    child: _age != 0 && _selectedEthnicity != null
                        ? ContinueButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SymptomePage(
                              age: _age,
                              sexe: _isMale,
                              ethnicite: _selectedEthnicity,
                            ),
                          ),
                        );
                      },
                    )
                        : GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Attention"),
                              content: Text("Tous les paramètres ne sont pas remplis"),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: ContinueButton(
                        onPressed: () {},
                      ),
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
