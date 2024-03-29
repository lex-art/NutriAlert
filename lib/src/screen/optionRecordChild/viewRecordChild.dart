import 'package:NutriAlert/src/widgets/app_iconBoy.dart';
import 'package:NutriAlert/src/widgets/app_iconGirl.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewRecordChild extends StatefulWidget {
  final String nombre,
      apellido,
      cui,
      direccion,
      edadMeses,
      estado,
      fechaRegistro,
      genero,
      madre,
      nacimiento,
      noCasa,
      noCel,
      noSector,
      padre,
      pueblo;

  const ViewRecordChild(
      {this.nombre,
      this.apellido,
      this.cui,
      this.direccion,
      this.edadMeses,
      this.estado,
      this.fechaRegistro,
      this.genero,
      this.madre,
      this.nacimiento,
      this.noCasa,
      this.noCel,
      this.noSector,
      this.padre,
      this.pueblo});

  @override
  _ViewRecordChildState createState() => _ViewRecordChildState();
}

class _ViewRecordChildState extends State<ViewRecordChild> {
  //-------------- variables del niño ---------------

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//----------------------------- Obtenemos el regiostro del niño-----------------------------
    // final child = ChildService().getRecordChild(widget.id);

    return Scaffold(
      appBar: AppBar(
          //pone de color blanco a todos los iconos del appBar
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Datos del niño",
            style: TextStyle(color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                widget.genero == "Masculino" ? AppBoy() : AppGirl(),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Cui: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.cui}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nombres: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.nombre}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Apellidos: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.apellido}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Género: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.genero} ", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Nacimieto: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.nacimiento}",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edad: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.edadMeses} Meses",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Madre: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.madre}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Padre: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.padre}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Teléfono: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.noCel}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No. Casa: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.noCasa}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No. sector: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.noSector}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dirrección: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.direccion}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Comunidad: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text("${widget.pueblo}", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
