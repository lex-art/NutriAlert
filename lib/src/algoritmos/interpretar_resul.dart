class Resultados {
  String pesoEdad(double pesoEdad) {
    if (pesoEdad <= 2 && pesoEdad >= -2) {
      return 'Peso Normal';
    }
    if (pesoEdad <= -2 && pesoEdad >= -3) {
      return 'Peso Bajo';
    }
    if (pesoEdad < -3) {
      return 'Bajo peso severo ';
    }
    if (pesoEdad > 2) {
      return 'Problema de crecimiento';
    }
    return 'Ninguna';
  }

  String longitudTallaEdad(double longEdad) {
    if (longEdad <= 2 && longEdad >= -2) {
      return 'Long/talla Normal';
    }
    if (longEdad <= -2 && longEdad >= -3) {
      return 'Retardo del Crecimiento';
    }
    if (longEdad < -3) {
      return 'Retardo del crecimiento Severo';
    }
    if (longEdad > 2) {
      return 'Caso extremo';
    }
    return 'Ninguna';
  }

  String pesoLongitudTallaZScore(double pesoLong) {
    if (pesoLong > 3) {
      return 'Obesidad';
    }
    if (pesoLong >= 2 && pesoLong <= 3) {
      return 'Sobrepeso';
    }
    if (pesoLong <= 2 && pesoLong >= -2) {
      return 'Normal';
    }
    if (pesoLong <= -2 && pesoLong >= -3) {
      return 'Aguda Moderada';
    }
    if (pesoLong < -3) {
      return 'Aguda Severa';
    }

    return 'Ninguna';
  }
}
