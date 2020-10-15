import 'dart:math';
import 'boyGrowthStandards.dart';

class TestNutritionalBoy {
  String longitudEdadBirdTo2Year(int edad, double longitud) {
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
    //a partir del segundo año hay un pequeño cambio en los calculos por eso el if
    //antes de los 24 meses, porque son otros valores
    if (edad < 24) {
      // posicion 0  = mediana  y posiscion 1 = Desviacion Estandar(DS)
      median = StandardsBoy().lengthForAgeBirthTo2YearsMedianDS(edad)[0];
      standardDeviation =
          StandardsBoy().lengthForAgeBirthTo2YearsMedianDS(edad)[1];
    } else {
      median = StandardsBoy().lengthForAge2To5YearsMedianDS(edad)[0];
      standardDeviation = StandardsBoy().lengthForAge2To5YearsMedianDS(edad)[1];
    }
    //Formula descrita anteriormente
    zScore = (longitud - median) / standardDeviation;
    return zScore.toStringAsFixed(2);
  }

  String pesoEdadBirdTo5Year(int edad, double peso) {
    /*Las puntuaciones z permiten la descripción precisa del tamaño fuera de los percentiles
    3 y 97 de una referencia de crecimiento. Para calcular los percentiles y las puntuaciones z ,
    los profesionales de la salud requieren los parámetros LMS (Lambda para el sesgo, Mu para la
    mediana y Sigma para el coeficiente de variación generalizado; Cole, 1990).

    Los puntajes Z pueden calcularse a partir de los parámetros de LMS comparando la medida
    del niño con el tamaño mediano para esa edad y dividiendo el resultado por la desviación 
    estándar. La inclusión del parámetro L en el cálculo (z = (((peso / M )^L) − 1 )/ ( L / S )) 
    tiene en cuenta cualquier sesgo en la referencia de crecimiento (Cole, 1989).

    SE TOMA LAS REFERENCIAS DE LA MEDIANA Y LMS  SEGUN ESTANDARES DE LA OMS:
    https://www.who.int/childgrowth/standards/es/ 
    https://www.who.int/childgrowth/standards/Technical_report.pdf
    */
    double zScore;
    //posicion 0 = Lambda , posicion 1 = Mediana, posicion 2 = Sigma
    double lambda = StandardsBoy().weigthForAgeBoy(edad)[0];
    double mediana = StandardsBoy().weigthForAgeBoy(edad)[1];
    double sigma = StandardsBoy().weigthForAgeBoy(edad)[2];

    zScore = (pow((peso / mediana), lambda) - 1) / (lambda * sigma);

    return zScore.toStringAsFixed(2);
  }

  String puntuacionZ(int edad, int altura, double peso) {
    double zScore;
    double lambda;
    double mediana;
    double sigma;

    ///se calcula peso para la longitud a niños menores de 2 años y
    ///se calcula peso para la estatura, altura o talla a niños de 2 a 5 años
    if (edad < 24) {
      lambda = StandardsBoy().weightForLengthBirthTo2YearsBOYSz(altura)[0];
      mediana = StandardsBoy().weightForLengthBirthTo2YearsBOYSz(altura)[1];
      sigma = StandardsBoy().weightForLengthBirthTo2YearsBOYSz(altura)[2];
    } else {
      lambda = StandardsBoy().weightForHeight2To5YearsBOYSz(altura)[0];
      mediana = StandardsBoy().weightForHeight2To5YearsBOYSz(altura)[1];
      sigma = StandardsBoy().weightForHeight2To5YearsBOYSz(altura)[2];
    }
    zScore = (pow((peso / mediana), lambda) - 1) / (lambda * sigma);
    return zScore.toStringAsFixed(2);
  }
}
