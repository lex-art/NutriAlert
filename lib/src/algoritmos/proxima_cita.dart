import 'package:date_format/date_format.dart';

class CalculateDate {
  String proximaCita(String age) {
    int edad = int.parse(age);
    var now = DateTime.now().toUtc().toLocal();
    String proxCita = "Finalizo su seguimiento";

    if (edad > 0 && edad < 24) {
      now = now.add(Duration(days: 30));
      //convertimos el mes a español
      String mes = month(formatDate(now, [M]));
      //estructuramos la fechaanter de retornarla
      return proxCita =
          formatDate(now, [d]) + "-" + mes + "-" + formatDate(now, [yyyy]);
    }
    if (edad >= 24 && edad < 36) {
      now = now.add(Duration(days: 91));
      //convertimos el mes a español
      String mes = month(formatDate(now, [M]));
      //estructuramos la fechaanter de retornarla
      return proxCita =
          formatDate(now, [d]) + "-" + mes + "-" + formatDate(now, [yyyy]);
    }
    if (edad >= 36 && edad < 60) {
      now = now.add(Duration(days: 182));
      //convertimos el mes a español
      String mes = month(formatDate(now, [M]));
      //estructuramos la fechaanter de retornarla
      return proxCita =
          formatDate(now, [d]) + "-" + mes + "-" + formatDate(now, [yyyy]);
    } else {
      return proxCita;
    }
  }

  String fechaActual() {
    var now = DateTime.now().toUtc().toLocal();
    String mes = month(formatDate(now, [M]));
    String fechaActual =
        formatDate(now, [d]) + "-" + mes + "-" + formatDate(now, [yyyy]);
    return fechaActual;
  }

//mapeo el mes a español
  String month(String mes) {
    switch (mes) {
      case 'Jan':
        return 'Ene';
        break;
      case 'Apr':
        return 'Abr';
        break;
      case 'Aug':
        return 'Ags';
        break;
      case 'Dec':
        return 'Dic';
        break;
      default:
        return mes;
    }
  }
}
