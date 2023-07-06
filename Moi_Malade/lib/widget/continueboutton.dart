import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widget/LanguageState.dart';

class ContinueButton extends StatelessWidget {
  final void Function() onPressed;

  ContinueButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0, // Modifiez la valeur pour ajuster la hauteur
      width: 300, // Modifiez la valeur pour ajuster la largeur
      child: ElevatedButton(
        onPressed: onPressed,
        child: Consumer<LanguageState>(
          builder: (context, languageState, child) {
            return Text(
              languageState.isEnglish ? 'Continue' : 'Continuer',
              style: TextStyle(fontSize: 16),
            );
          },
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFB7ACF7),
        ),
      ),
    );
  }
}
