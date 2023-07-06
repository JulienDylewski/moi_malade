import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageState with ChangeNotifier {
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  void toggleLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }
}
class LanguageSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageState = Provider.of<LanguageState>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Fr', style: TextStyle(color: Colors.white)),
        Switch(
          value: languageState.isEnglish,
          activeColor: Colors.white,
          onChanged: (bool value) {
            languageState.toggleLanguage();
          },
        ),
        Text('En', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
