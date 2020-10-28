import 'package:NutriAlert/src/algoritmos/boy/testNutritionalBoy.dart';
import 'package:NutriAlert/src/algoritmos/girl/testNutritionalGirl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //como realizaremos varias pruenas untarias las vamos a agrupar
  group("Pruebas unitarias TestNutricional niñ@s", () {
    ///para realizar la pruebas unitarias en flutter podemos usar una funciuon llamada test, esta
    ///recibe dos parametros un string que es la descripcion del test y una funcion anonima,
    ///que representa la prueba a realizar
    test("Probar test nutricional niña ", () {
      ///Para esta prueba tenemos un ejemplo real para un niño de 24 meses,
      ///para este caso los estándares para este niño seria:
      ///
      /// puntuacion z longitud/ Talla para la edad -> Mediana = 87.8161, Desviacion estandar =  3.0551
      /// Formula = Z = (valor observado) - (valor de la mediana de referencia para edad y sexo) /
      /// desvío estándar de la población de referencia  -> RESULTADO = 0.0601
      ///
      /// Para estas últimas dos, la formula es lasiguiente ->  z = (((peso / M )^L) − 1 )/ ( L * S )
      /// peso para la edad -> lambda = -0.0137, mediana = 12.1515 , Sigma = 0.11426  -> RESULTADO = 0.06019
      ///
      /// puntuacion z peso para la lungitud / talla > lambda = -0.3521 , mediana =12.2382 , Sigma = 0.08082  -> RESULTADO = -0.03870
      ///
      ///-----------------para estas pruebas voy a utilizar la "regla" Given(dado), when(cuando), then(entonces)---------------
      ///
      ///Given(dado) es donde declaramos nuestras precondiciones
      var alturaLongitud = 88;
      var peso = 12.2;
      var edad = 24;

      //when(cuándo) se calcula los puntajes z´s
      var zLongTallaEdad =
          TestNutritionalBoy().longitudEdadBirdTo2Year(edad, alturaLongitud);
      var zPesoEdad = TestNutritionalBoy().pesoEdadBirdTo5Year(edad, peso);
      var zScore = TestNutritionalBoy().puntuacionZ(edad, alturaLongitud, peso);

      //the(entonces) comparamos los resultados

      ///expect es  la funcion que hace la prueba unitaria, osea es decir lo que se espera que realice
      ///recibe dos parametros la primera (actual) son los valores que se van a probar y matcher
      ///que es valor que se espera obtener
      //test Longitud / talla para la edad
      expect(zLongTallaEdad.toStringAsFixed(5), 'Infinity');
      //test Longitud / talla para la edad
      expect(zPesoEdad.toStringAsFixed(5), 'Nan');
      //test Longitud / talla para la edad
      expect(zScore.toStringAsFixed(5), 'NaN');
    });

    test("Probar test nutricional de una niña ", () {
      ///Para esta prueba tenemos un ejemplo real para un niño de 36 meses,
      ///para este caso los estándares para esta niña seria:
      ///
      ///
      /// puntuacion z longitud/ Talla para la edad -> Mediana = 95.0515, Desviacion estandar =  3.8078
      /// Formula = Z = (valor observado) - (valor de la mediana de referencia para edad y sexo) /
      /// desvío estándar de la población de referencia  -> RESULTADO = 0.24909
      ///
      /// Para estas últimas dos, la formula es lasiguiente ->  z = (((peso / M )^L) − 1 )/ ( L * S )
      /// peso para la edad -> lambda = -0.3201 , mediana = 13.8503 , Sigma = 0.12919 -> RESULTADO = 0.08307
      ///
      /// puntuacion z peso para la lungitud / talla > lambda = -0.3833  , mediana =14.1466 , Sigma = 0.08994  -> RESULTADO = -0.11605
      ///
      ///-----------------para estas pruebas voy a utilizar la "regla" Given(dado), when(cuando), then(entonces)---------------
      ///
      ///Given(dado) es donde declaramos nuestras precondiciones
      var alturaLongitud = 966;
      var peso = 164.0;
      var edad = 366;

      //when(cuándo) se calcula los puntajes z´s
      var zLongTallaEdad =
          TestNutritionalGirl().longitTallaParaEdadGirl(edad, alturaLongitud);
      var zPesoEdad = TestNutritionalGirl().pesoEdad(edad, peso);
      var zScore =
          TestNutritionalGirl().puntuacionZ(edad, alturaLongitud, peso);

      //the(entonces) comparamos los resultados

      ///expect es  la funcion que hace la prueba unitaria, osea es decir lo que se espera que realice
      ///recibe dos parametros la primera (actual) son los valores que se van a probar y matcher
      ///que es valor que se espera obtener
      //test Longitud / talla para la edad
      expect(zLongTallaEdad.toStringAsFixed(5), 'Infinity');
      //test Longitud / talla para la edad
      expect(zPesoEdad.toStringAsFixed(5), 'NaN');
      //test Longitud / talla para la edad
      expect(zScore.toStringAsFixed(5), 'NaN');
    });
  });
}
