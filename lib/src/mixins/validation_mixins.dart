///Los Mixins son una forma de reutilizar código de una clase en múltiples jerarquías de clase.
///mas que todo para hacer validaciones como en este caso validar formularios y tantas cosas
class ValidationMixins {
  //--------------------- Métodos de validación para el formulario de crear usuario ------------
  String validateEmail(String value) {
    if (!value.contains('@') & !value.contains('.com')) return "Email Invalido";
    return null;
  }

  String validatePassword(String value) {
    if (value.length < 6) return "Contraseña invalida";
    return null;
  }

  String validateNameUser(String value) {
    if (value.length < 0 ) return "Ingrese sus nombres";
    return null;
  }

  String validateLastName(String value) {
    if (value.length < 0 ) return "Ingrese sus apellidos";
    return null;
  }

  String validateDPI(String value) {
    if (value.length < 13) return "Ingrese un dpi valido";
    return null;
  }

  String validatePhone(String value) {
    if (value.length < 8) return "Ingrese un número de telefono valido";
    return null;
  }
}
