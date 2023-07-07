import 'dart:io';

import 'package:appsivalmattel/app/ui/views/desabastecimiento/desabastecimiento_controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/models/response/response_distribuidora_model.dart';
import '../../../data/models/response/response_puntoventa_model.dart';
import '../../../data/providers/distribuidora_provider.dart';
import '../../../data/providers/puntoventa_provider.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class DesabastecimientoView extends StatefulWidget {
  const DesabastecimientoView({super.key});

  @override
  State<DesabastecimientoView> createState() => _DesabastecimientoViewState();
}

class _DesabastecimientoViewState extends State<DesabastecimientoView> {
  DistribuidoraProvider distribuidoraProvider = DistribuidoraProvider();
  List<ResponseDistribuidoraModel> distribuidoras = [];

  PuntoventaProvider puntoventaProvider = PuntoventaProvider();
  List<ResponsePuntoventaModel> puntoventas = [];

  String empresanombre = "Empresa";
  String empresaid = "Seleccione ...";
  int buscaempresaid = 0;
  String puntoventa = "Punto Ventas";
  String puntoventaid = "Seleccione...";
  DateTime fecha = DateTime.now();
  String p01 = "0";
  String p02 = "0";
  String p03 = "0";
  String p04 = "0";
  String p05 = "0";
  String p06 = "0";
  String p07 = "0";
  List lp = List.generate(11, (i) => i * 10);

  File? imageFile1;
  File? imageFile11;

  TextEditingController fechaController = TextEditingController();
  @override
  void initState() {
    getAllSqlite();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAllSqlite() async {
    final response2 = await ResponseDistribuidoraModel().query("");
    distribuidoras = (response2 as List)
        .map(
          (data) => ResponseDistribuidoraModel.fromJson(data),
        )
        .toList();

    //final response1 = await ResponsePuntoventaModel().query("");
    final response1 = await ResponsePuntoventaModel()
        .query("WHERE distribuidora_id=?", arguments: [buscaempresaid]);
    puntoventas = (response1 as List)
        .map(
          (data) => ResponsePuntoventaModel.fromJson(data),
        )
        .toList();

    setState(() {});
  }

  getPuntoVenta() async {
    final response1 = await ResponsePuntoventaModel()
        .query("WHERE distribuidora_id=?", arguments: [buscaempresaid]);
    puntoventas = (response1 as List)
        .map(
          (data) => ResponsePuntoventaModel.fromJson(data),
        )
        .toList();

    setState(() {});
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    ).then(
      (value) {
        setState(() {
          fecha = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DesabastecimientoController>(
      init: DesabastecimientoController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.red.shade50,
          appBar: AppBar(
            title: const Text("Desabastecimiento"),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            //.symmetric(horizontal: 10, vertical: 30),
            children: [
              Obx(
                () => Center(
                  child: Text(
                    "${controller.userNombre}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.business_sharp,
                  size: 40.0,
                  color: Colors.red,
                ),
                title: Text(empresanombre),
                subtitle: Text(empresaid),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _distribuidoras(context, distribuidoras);
                },
              ),
              const SizedBox(height: 15.0),
              ListTile(
                leading: const Icon(
                  Icons.storefront,
                  size: 40.0,
                  color: Colors.red,
                ),
                title: Text(puntoventa),
                subtitle: Text(puntoventaid),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _puntoventas(context, puntoventas);
                },
              ),
              const SizedBox(height: 15.0),
              MaterialButton(
                onPressed: _showDatePicker,
                minWidth: 170.0,
                height: 30.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Fecha",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      SizedBox(width: 20),
                      Icon(Icons.calendar_today,
                          color: Colors.white, size: 24.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Text(
                fecha.toString(),
                style: const TextStyle(
                    fontSize: 18.0, backgroundColor: Colors.white10),
              ),
              const SizedBox(height: 15.0),
              const Text("Ingrese Fecha",
                  style: TextStyle(
                      fontSize: 18.0, backgroundColor: Colors.white10)),
              const SizedBox(height: 15.0),
              _inputdate(context),
              const SizedBox(height: 15.0),
              ListTile(
                title: const Text(
                  "1. En que % de carga se encuentra Barbie?",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  p01,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _p0(context, lp, 1);
                },
              ),
              const SizedBox(height: 15.0),
              imageFile1 != null
                  ? Image.file(imageFile1!)
                  : const Text("Sin Imagen"),
              const SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  _getImage1(source: ImageSource.camera);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tomar Fotografia",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons.camera_alt_sharp, size: 24.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              //fin Foto
              imageFile11 != null
                  ? Image.file(imageFile11!)
                  : const Text("Sin Imagen"),
              const SizedBox(height: 15.0),
              MaterialButton(
                onPressed: () {
                  _getImage11(source: ImageSource.camera);
                },
                minWidth: 170.0,
                height: 50.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Tomar Fotografia",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              //fin Foto
              const SizedBox(height: 15.0),
              ListTile(
                title: const Text(
                  "2. En que % de carga se encuentra Polly Poket?",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  p02,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _p0(context, lp, 2);
                },
              ),
              const SizedBox(height: 15.0),
              ListTile(
                title: const Text(
                  "3. En que % de carga se encuentra Disney ?",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  p03,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _p0(context, lp, 3);
                },
              ),
              const SizedBox(height: 15.0),
              ListTile(
                title: const Text(
                  "4. En que % de carga se encuentra Hot Wheels?",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  p04,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _p0(context, lp, 4);
                },
              ),
              const SizedBox(height: 15.0),
              ListTile(
                title: const Text(
                  "5. En que % de carga se encuentra Jurassic World?",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  p05,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _p0(context, lp, 5);
                },
              ),
              const SizedBox(height: 15.0),
              ListTile(
                title: const Text(
                  "6. En que % de carga se encuentra Fisher Price?",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  p06,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _p0(context, lp, 6);
                },
              ),
              const SizedBox(height: 15.0),
              ListTile(
                title: const Text(
                  "7. En que % de carga se encuentra Mega Blocks?",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                  p07,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _p0(context, lp, 7);
                },
              ),
              const SizedBox(height: 15.0),
              const Text(
                "Comentario",
                style: TextStyle(fontSize: 17.0),
              ),
              const TextField(
                maxLines: 3,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
                decoration: InputDecoration(
                  hintText: "Ingrese Comentario",
                  filled: true,
                  fillColor: Color.fromARGB(255, 221, 237, 245),
                ),
              ),
              const SizedBox(height: 15.0),
              MaterialButton(
                onPressed: () {
                  //controller.getUsuario();
                },
                //elevation: 10.0,
                minWidth: 170.0,
                height: 50.0,
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: const Text(
                  "Guardar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _inputdate(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: fechaController,
      readOnly: true,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 17,
      ),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 221, 237, 245),
        icon: Icon(
          Icons.calendar_today_sharp,
          color: Colors.red,
        ),
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2024),
        );
        if (picked != null) {
          setState(() {
            //fechaController.text = picked.toString();
            fechaController.text = DateFormat('yyy-MM-dd').format(picked);
          });
        }
      },
    );
  }

  void _getImage1({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        imageFile1 = File(file!.path);
        //print(imageFile1!.path);
      });
    }
  }

  void _getImage11({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        imageFile11 = File(file!.path);
        //print(imageFile1!.path);
      });
    }
  }

  _p0(BuildContext context, lp, p0) {
    showModalBottomSheet(
      barrierColor: Colors.black12,
      backgroundColor: Colors.white,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400.0,
          child: ListView.builder(
            itemCount: lp.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(lp[index].toString()),
              onTap: () {
                switch (p0) {
                  case 1:
                    p01 = lp[index].toString();
                  case 2:
                    p02 = lp[index].toString();
                  case 3:
                    p03 = lp[index].toString();
                  case 4:
                    p04 = lp[index].toString();
                  case 5:
                    p05 = lp[index].toString();
                  case 6:
                    p06 = lp[index].toString();
                  case 7:
                    p07 = lp[index].toString();
                }

                Navigator.pop(context);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

  _distribuidoras(BuildContext context, distribuidoras) {
    showModalBottomSheet(
      barrierColor: Colors.black12,
      backgroundColor: Colors.blue.shade100,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400.0,
          child: ListView.builder(
            itemCount: distribuidoras.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(distribuidoras[index].nombre),
              onTap: () {
                empresanombre = distribuidoras[index].nombre;
                empresaid = distribuidoras[index].id.toString();
                buscaempresaid = distribuidoras[index].id;
                getPuntoVenta();
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

  _puntoventas(BuildContext context, puntoventas) {
    showModalBottomSheet(
      barrierColor: Colors.black12,
      backgroundColor: Colors.blue.shade200,
      isDismissible: true,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400.0,
          child: ListView.builder(
            itemCount: puntoventas.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(puntoventas[index].nombre),
              onTap: () {
                puntoventa = puntoventas[index].nombre;
                puntoventaid = puntoventas[index].id.toString();
                Navigator.pop(context);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

/*                 Container(
                width: 600,
                height: 360,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  //image: DecorationImage(
                  //  image: FileImage(imageFile!),
                  //),
                  border: Border.all(
                    width: 8,
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
*/
}
