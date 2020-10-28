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

  String validateMother(String value) {
    if (value.length < 1) return "Ingrese una Nombre";
    return null;
  }

  String validateAge(String value) {
    if (value.length < 1) {
      return "Ingrese un valor";
    } else {
      var val = int.parse(value);
      if (val > 60) return "La edad no es valida, menor a 60 meses";
    }
    return null;
  }

  String validateTest(value) {
    if (value.length < 1) return "Ingrese un valor";
    return null;
  }
String validarAltura(value) {
    if (value.contains('.')) return "Ingrese un dato,  o quite el punto decimal";
    return null;
  }

  //------------------------------ Validaciones del resultado del test -------------------------
  String validateResult(String value) {
    if (value.length <= 0) {
      return "Ingrese un valor";
    }
   // if (value.contains('-')) {
   //   var l = value.replaceAll("-", "0");
   //   var val = int.parse(l);
   //   if (val > 3) return "Valor incorrecto";
   // } else {
   //   var val = int.parse(value);
   //   if (val > 3) return "Valor incorrecto";
   // }
    return null;
  }
}
