import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LanguageState.dart';
class Background extends StatelessWidget {
  final String title;
  final String titleENG;
  final bool showLanguageSwitch;
  final double top;  // Ajoutez ces lignes
  final double left;
  final double right;
  final TextAlign textAlign;

  Background({
    required this.title,
    required this.titleENG,
    this.showLanguageSwitch = false,
    this.top = 50,
    this.left = 0,
    this.right = 0,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xFF333745),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: left,
              right: right,
              child: Consumer<LanguageState>(
                builder: (context, languageState, child) {
                  return Text(
                    languageState.isEnglish ? title : titleENG,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: textAlign,
                  );
                },
              ),
            ),
            if (showLanguageSwitch)
              Positioned(
                right: 20,
                top: 50,
                child: LanguageSwitch(),
              ),
          ],
        ),
      ),
    );
  }
}




class WhiteBox extends StatelessWidget {
  final Widget child;

  WhiteBox({required this.child, required List<Positioned> children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(top: 120),
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(50.0),
          topLeft: Radius.circular(50.0),
        ),
      ),
      child: child,
    );
  }
}
class TextBienvenue extends StatelessWidget{
  final String texte;
  final String texteENG;

  TextBienvenue({required this.texte, required this.texteENG});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 250),
        child: Consumer<LanguageState>(
        builder: (context, languageState, child) {
      return Text(
        languageState.isEnglish ? texteENG : texte ,
          style: TextStyle(
          fontSize: 18,
          color: Color(0xff707070),
          ),
        textAlign: TextAlign.center,
      );
        },
        ),
    );
  }
}


