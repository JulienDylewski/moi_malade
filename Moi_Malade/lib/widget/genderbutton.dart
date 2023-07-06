import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LanguageState.dart';

class GenderButtons extends StatefulWidget {
  final void Function(bool) onGenderChange;

  GenderButtons({required this.onGenderChange});

  @override
  _GenderButtonsState createState() => _GenderButtonsState();
}

class _GenderButtonsState extends State<GenderButtons> {
  bool _isMaleButtonSelected = false;
  bool _isFemaleButtonSelected = false;

  void _toggleGenderButton(String gender) {
    setState(() {
      if (gender == 'male') {
        _isMaleButtonSelected = !_isMaleButtonSelected;
        _isFemaleButtonSelected = false;
      } else {
        _isFemaleButtonSelected = !_isFemaleButtonSelected;
        _isMaleButtonSelected = false;
      }
    });
    widget.onGenderChange(_isMaleButtonSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: () {
            _toggleGenderButton('male');
          },
          child: Consumer<LanguageState>(
            builder: (context, languageState, child) {
              return Text(
                languageState.isEnglish ? 'Man' : 'Homme',
              );
            },
          ),
          style: OutlinedButton.styleFrom(
            primary: _isMaleButtonSelected
                ? Color(0xFF6200EE)
                : Color(0xFF6200EE),
            backgroundColor: _isMaleButtonSelected
                ? Color(0xFFD7D0FF)
                : Colors.white,
            side: BorderSide(color: Color(0xFF6200EE)),
          ),
        ),
        SizedBox(width: 10),
        OutlinedButton(
          onPressed: () {
            _toggleGenderButton('female');
          },
          child: Consumer<LanguageState>(
            builder: (context, languageState, child) {
              return Text(
                languageState.isEnglish ? 'Woman' : 'Femme' ,
              );
            },
          ),
          style: OutlinedButton.styleFrom(
            primary: _isFemaleButtonSelected
                ? Color(0xFF6200EE)
                : Color(0xFF6200EE),
            backgroundColor: _isFemaleButtonSelected
                ? Color(0xFFD7D0FF)
                : Colors.white,
            side: BorderSide(color: Color(0xFF6200EE)),
          ),
        ),
      ],
    );
  }
}
