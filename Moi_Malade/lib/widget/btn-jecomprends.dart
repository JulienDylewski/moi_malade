import 'package:flutter/material.dart';
import 'package:moi_malade/fr/AgePage.dart';
import 'package:provider/provider.dart';
import '../widget/LanguageState.dart';

class BTNJeComprend extends StatelessWidget {
  const BTNJeComprend();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  AgePage()));
      },
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF6200EE),
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
           Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 200.0,
              height: 35.0,
              child: Consumer<LanguageState>(
                builder: (context, languageState, child) {
                  return Text(
                    languageState.isEnglish ? 'Continue' : 'Continuer',
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
