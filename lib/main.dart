import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:NutriAlert/src/screen/login_screen.dart';
import 'package:NutriAlert/src/screen/nurtriAlert_app.dart';
import 'package:NutriAlert/src/screen/options_screens/editProfile_screen.dart';
import 'package:NutriAlert/src/screen/options_screens/help.dart';
import 'package:NutriAlert/src/screen/options_screens/registrationUser_screen.dart';
import 'package:NutriAlert/src/screen/record_child.dart';
import 'package:NutriAlert/src/screen/register_child.dart';
import 'package:NutriAlert/src/screen/test_nutritional_release.dart';
import 'package:NutriAlert/src/screen/visits.dart';
import 'package:NutriAlert/src/screen/options_screens/listUser_screen.dart';

Future<void> main() async {
  //nueva actualizacion de agosto necesitamos implementar esto para que funcione firebase
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      //-------------------colores en general que usara la app----------------
      textTheme: TextTheme(
        body1: TextStyle(color: Colors.black54, fontWeight: FontWeight.normal),
        title: TextStyle(color: Colors.white),
      ),
      appBarTheme: AppBarTheme(
          color: Color(0xff88CC00),
          textTheme: TextTheme(
            title: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          )),
      primaryColor: Color(0xff88CC00),
      accentColor: Color(0xff001133),
      buttonColor: Color(0xff006CD9),
      canvasColor: Colors.white,
    ),
    home: LoginScreen(),
//------------------------------ Navegación --------------------------------------
    //ruta principal
    initialRoute: LoginScreen.routName,
    //demas rutas de la app
    routes: <String, WidgetBuilder>{
      NutriAlert.routName: (BuildContext context) => NutriAlert(),
      TestNutritionalRelease.routName: (BuildContext context) => TestNutritionalRelease(),
      RegisterChildren.routName : (BuildContext context) => RegisterChildren(),
      Visits.routName: (BuildContext context) => Visits(),
      RecordChild.routName: (BuildContext context) => RecordChild(),
//----------------------------- Páginas Secundarias ------------------------------
      //ResultTest.routName: (BuildContext context) => ResultTest(),
      //StoryChild.routName: (BuildContext context) => StoryChild(),
//----------------------------- Páginas Ocpiones ------------------------------
      EditProfile.routName: (BuildContext context) => EditProfile(),
      User.routName: (BuildContext context) => User(),
      CreateUser.routName: (BuildContext context) => CreateUser(),
      Help.routName: (BuildContext context) => Help(),
    },
  ));
}
