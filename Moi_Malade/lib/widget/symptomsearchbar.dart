import 'package:flutter/material.dart';
import '../Model/Symptom.dart';
import 'package:provider/provider.dart';
import '../widget/LanguageState.dart';

class SymptomSearchWidget extends StatelessWidget {
  final List<Symptom> symptomsList;
  final Function(Symptom) onSelected;
  final TextEditingController _searchController;

  SymptomSearchWidget({required this.symptomsList, required this.onSelected, required TextEditingController searchController})
      : _searchController = searchController;

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageState>(builder: (context, languageState, child) {
      return Autocomplete<Symptom>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return symptomsList;
          }
          return symptomsList.where((Symptom symptom) =>
              (languageState.isEnglish ? symptom.nomEn : symptom.nomFr).toLowerCase().contains(textEditingValue.text.toLowerCase())
          );
        },
        displayStringForOption: (Symptom option) => languageState.isEnglish ? option.nomEn : option.nomFr,
        onSelected: (Symptom selection) {
          onSelected(selection);
        },
        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<Symptom> onSelected, Iterable<Symptom> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 4.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  padding: EdgeInsets.all(8.0),
                  children: options.map((Symptom symptom) {
                    return GestureDetector(
                      onTap: () {
                        onSelected(symptom);
                      },
                      child: ListTile(
                        title: Text(languageState.isEnglish ? symptom.nomEn : symptom.nomFr),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
