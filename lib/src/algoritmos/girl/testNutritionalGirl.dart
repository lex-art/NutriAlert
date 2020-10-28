import 'dart:math';
import 'girlGrowthStandards.dart';

class TestNutritionalGirl{
  double longitTallaParaEdadGirl(int edad, int longitudEstatura) {
    /*Puntaje Z o puntaje de desvío estándar es un criterio estadístico universal.
    Define la distancia a la que se encuentra un punto (un individuo) determinado,
    respecto del centro de la distribución normal en unidades estandarizadas llamadas Z. 
    En su aplicación a la antropometría, es la distancia a la que se ubica la medición 
    de un individuo con respecto al percentil 50 (mediana para una distribución normal) 
    de la población de referencia para su edad y sexo, en unidades de desvío estándar. 

    Por tanto, puede adquirir valores positivos o negativos. La fórmula de cálculo en distribuciones 
    estadísticas normales –gaussianas- (como la talla/edad) es la siguiente: 
    Z = (valor observado) - (valor de la mediana de referencia para edad y sexo)/desvío estándar de la
    población de referencia    
     
    Cálculo de estatura
    - puntaje Z = (x – p50)/DE
    - x: estatura del paciente
    - p50: percentil 50 o mediana a la edad del paciente (D0)
    - DE: desvío estándar para sexo y edad
    Se resta la mediana de la distribución de frecuencias al valor correspondiente y 
    se divide el resultado por el desvío estándar
    
    SE TOMA LAS REFERECIAS DE  MERDIANA Y DESVIACION ESTANDAR SEGUN ESTANDARES DE LA OMS:
    https://www.who.int/childgrowth/standards/es/
    https://www.who.int/childgrowth/standards/Technical_report.pdf    */

    double zScore;
    double median;
    double standardDeviation;
    //* NOTA: es longitud y se usa otra tabla para niños menores a dos años y
    // es Talla / Estatura para niñas mayores a 3 años y se usa otra tabla
    if (edad < 24) {
      // posicion 0  = mediana  y posiscion 1 = Desviacion Estandar(DS)
      var standardGirl = StandardGirl().lengthForAgeGIRLSBirthTo2Years(edad);
      median = standardGirl[0];
      standardDeviation = standardGirl[1];
    } else {
      var standardGirl = StandardGirl().heightForAgeGIRLS2To5Years(edad);
      median = standardGirl[0];
      standardDeviation = standardGirl[1];
    }
    //Formula descrita anteriormente
    zScore = (longitudEstatura - median) / standardDeviation;

    return zScore;
  }

  double pesoEdad(int edad, double peso) {
    /*Las puntuaciones z permiten la descripción precisa del tamaño fuera de los percentiles
    3 y 97 de una referencia de crecimiento. Para calcular los percentiles y las puntuaciones z ,
    los profesionales de la salud requieren los parámetros LMS (Lambda para el sesgo, Mu para la
    mediana y Sigma para el coeficiente de variación generalizado; Cole, 1990).

    Los puntajes Z pueden calcularse a partir de los parámetros de LMS comparando la medida
    del niño con el tamaño mediano para esa edad y dividiendo el resultado por la desviación 
    estándar. La inclusión del parámetro L en el cálculo (z = (((peso / M )^L) − 1 )/ ( L * S )) 
    tiene en cuenta cualquier sesgo en la referencia de crecimiento (Cole, 1989).

    SE TOMA LAS REFERENCIAS DE LA MEDIANA Y LMS  SEGUN ESTANDARES DE LA OMS:
    https://www.who.int/childgrowth/standards/es/ 
    https://www.who.int/childgrowth/standards/Technical_report.pdf
    */
    double zScore;
    //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
    var estandardGirl = StandardGirl().weightForAgeGIRLSbirthTo5Years(edad);
    double lambda = estandardGirl[0];
    double mediana = estandardGirl[1];
    double sigma = estandardGirl[2];
    //NOTA: aqui no hay diferencia hasta los 2 años como lo es en longitiuda/Talla para la edad
    //Aqui La tabla funciona desde el nacimiento hasta los 5 años

    zScore = (pow((peso / mediana), lambda) - 1) / (lambda * sigma);

    return zScore;
  }

  double puntuacionZ(int edad, int altura, double peso) {
    double zScore;
    double lambda;
    double mediana;
    double sigma;

    ///NOTA: se calcula peso para la longitud a niños menores de 2 años (24 meses) y
    ///se calcula peso para la Estatura/Altura o talla a niños de 2 a 5 años
    if (edad < 24) {
      var standardGirl =
          StandardGirl().weightForLengthGIRLSbirthTo2Years(altura);
      //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
      lambda = standardGirl[0];
      mediana = standardGirl[1];
      sigma = standardGirl[2];
    } else {
      var standardGirl = StandardGirl().weightForHeightGIRLS2To5Years(altura);
      //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
      lambda = standardGirl[0];
      mediana = standardGirl[1];
      sigma = standardGirl[2];
    }
    zScore = (pow((peso / mediana), lambda) - 1) / (lambda * sigma);
    return zScore;
  }
}
