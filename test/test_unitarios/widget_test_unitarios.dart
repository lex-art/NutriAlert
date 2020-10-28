import 'package:NutriAlert/src/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //tests enfocados a probar los widgets de la palicaicón
  group("test para widgets", () {
    ///El objetivo de una prueba de widget es verificar que la interfaz de
    ///usuario de cada widget se ve y se comporta como se espera. Básicamente,
 ///las pruebas se realizan volviendo a renderizar los widgets en código con datos simulados.
 testWidgets("test caja de texto widget login", (WidgetTester tester) async {
   //probamos las cajas de texto y los botones de la vista login

   //encontrar todos los widgets necesarios
   final testEmailTextField = find.byKey(ValueKey('correo'));
   final testPassTextField = find.byKey(ValueKey('pass'));

   //ejecutar la prueba real
   await tester.pumpWidget(MaterialApp(
     home: LoginScreen(),
   ));
   await tester.enterText(testEmailTextField, "Probando textFiel Correo");
   await tester.enterText(testPassTextField, "Probando textFiel password");
   await tester.pump(); //reconstruye un widget

   //comprobar salidas
   expect(find.text("Probando textFiel"), findsOneWidget);
   expect(find.text("Probando textFiel password"), findsOneWidget);
 });

    testWidgets("test boton widget login", (WidgetTester tester) async {
      //probamos los botones de la vista login

      //encontrar todos los widgets necesarios
      final button = find.text('Iniciar sesión');

      //ejecutar la prueba real
      await tester.pumpWidget(MaterialApp(
        home: LoginScreen(),
      ));

      expect(button, findsOneWidget);

      //probando boton
      await tester.tap(button);
      await tester.pump(); //reconstruye un widget

      expect(find.text("Iniciar sesión"), findsOneWidget);
    });
  });
}
