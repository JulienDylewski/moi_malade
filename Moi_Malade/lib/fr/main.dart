import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:moi_malade/widget/appbar.dart';
import 'package:moi_malade/widget/background.dart';
import 'package:moi_malade/widget/btn-jecomprends.dart';
import 'package:moi_malade/widget/continueboutton.dart';
import 'package:provider/provider.dart';
import '../widget/LanguageState.dart';
import 'AgePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
    create: (context) => LanguageState(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Background(
        title: 'Moi Malade',
        titleENG: 'Moi Malade',
        left: 50,
        right: 20,
       textAlign: TextAlign.left,
       showLanguageSwitch: true,),
          WhiteBox(
            children: [],
            child: Stack(
              children: [
                Positioned(
                  child: TextBienvenue(texte: 'Bienvenue\n\n Vérifiez vos symptômes et découvrez ce qui pourrait en être la cause en quelques clics.\n Nous allons vous poser un certain nombre de questions afin de déterminer les causes possibles de vos symptômes.\n Les informations que vous donnez sont sécurisées et ne seront pas partagées.', texteENG: 'Welcome\n\nCheck your symptoms and find out what could be causing them with just a few clicks.\nWe will ask you a number of questions to determine the possible causes of your symptoms.\nThe information you provide are secure and will not be shared.',),
                ),
                Positioned(
                  top: 30,
                  left: 50,
                  right: 50,
                  child: Image.asset('assets/images/image_5.png', width: 150, height: 150),
                ),
                Positioned(
                  top: 550,
                  left: 50,
                  right: 50,
                  child: ContinueButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AgePage()),
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
