import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Probar Nutri alert', () {
    // Primero, define los Finders. Podemos usarlos para localizar Widgets desde
    // la suite de test. Nota: los Strings proporcionados al método `byValueKey`
    // deben ser los mismos que los Strings utilizados para las Keys del paso 1.

    final correoTextFinder = find.byValueKey('correo');
    final passTextFinder = find.byValueKey('pass');

    final buttonFinder = find.byValueKey('boton');

    FlutterDriver driver;

    // Conéctate al driver de Flutter antes de ejecutar cualquier test
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Cierra la conexión con el driver después de que se hayan completado los tests
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test(
      'Inisio de sesión',
      () async {
        //una prueba para inicio de sesion
        await driver.clearTimeline();
        await driver.tap(correoTextFinder);
        await driver.enterText('alex@gmail.com');

        await driver.tap(passTextFinder);
        await driver.enterText('123456');

        await driver.tap(buttonFinder);
        await Future.delayed(Duration(seconds: 15));
        //await driver.waitFor(find.text('Bienvenido'));
      },
      timeout: Timeout(
        Duration(minutes: 2),
      ),
    );
  });
}
