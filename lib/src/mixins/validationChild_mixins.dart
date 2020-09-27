class ValidationChildMixins {
  
   String validateCui(String value) {
    if (value.length < 13) return "Ingrese un CUI correcto";
    return null;
  }

  String validateName(String value) {
    if (value.length < 1) return "Ingrese un nombre";
    return null;
  }
  String validateApe(String value) {
    if (value.length < 1) return "Ingrese un Apellido";
    return null;
  }
  String validateBirth(String value) {
    if (value.length < 1) return "Ingrese una fecha";
    return null;
  }
  String validatAge(String value) {
    var val = int.parse(value);
    if (val < 61) return "La edad no es valida, menor a 60 meses";
    return null;
  }
}