import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LanguageState.dart';

class AgeSlider extends StatefulWidget {
  final void Function(double) onAgeChange;

  AgeSlider({required this.onAgeChange});

  @override
  _AgeSliderState createState() => _AgeSliderState();
}

class _AgeSliderState extends State<AgeSlider> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: <Widget>[
            Consumer<LanguageState>(
              builder: (context, languageState, child) {
                return Text(
                  languageState.isEnglish ? 'How old are you?'  : 'Quel est votre âge ?' ,
                  style: TextStyle(fontSize: 24),
                );
              },
            ),
            Text(_currentSliderValue.toInt().toString(),
                style: TextStyle(fontSize: 24)),
            Slider(
              value: _currentSliderValue,
              min: 0,
              max: 100,
              divisions: 100,
              activeColor: Color(0xFFB7ACF7),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
                widget.onAgeChange(_currentSliderValue);
              },
            ),
            ],
      ),

    );
  }
}

class VelocitySliderWidget extends StatelessWidget {
  final double _currentSliderValue;
  final Function(double) onChanged;

  VelocitySliderWidget({required double currentSliderValue, required Function(double) onChanged})
      : _currentSliderValue = currentSliderValue,
        onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      min: 0,
      max: 100,
      divisions: 100,
      activeColor: Color(0xFFB7ACF7),
      onChanged: (double value) {
        onChanged(value);
      },
    );
  }
}
