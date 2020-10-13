mixin reult {
  String pesoEdad(int pesoEdad) {
    if (pesoEdad <= 2 && pesoEdad >= -2) {
      return 'Peso Normal';
    }
    if (pesoEdad >= -2) {
      return 'Peso Bajo';
    }
    return 'Valor Incorrecto';
  }

  String longitudEdad(int longEdad) {
    if (longEdad <= 2 && longEdad >= -2) {
      return 'Longitud/talla Normal';
    }
    if (longEdad >= -2) {
      return 'Retardo del Crecimiento';
    }
    return 'Valor Incorrecto';
  }

  String pesoLongitud(int pesoLong) {
    if (pesoLong > 3) {
      return 'Obesidad';
    }
    if (pesoLong >= 2 && pesoLong <= 3) {
      return 'Sobrepeso';
    }
    if (pesoLong < 2 && pesoLong < -2) {
      return 'Normal';
    }
    if (pesoLong > -3) {
      return 'Des. Aguda Severa';
    }
    if (pesoLong >= -2 && pesoLong <= -3) {
      return 'Aguda Moderada';
    }
    return 'Valor Incorrecto';
  }
}
