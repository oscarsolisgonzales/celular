import 'package:flutter/material.dart';

import '../../../data/models/response/response_distribuidora_model.dart';
import '../../../data/models/response/response_puntoventa_model.dart';
import '../../../data/providers/distribuidora_provider.dart';
import '../../../data/providers/puntoventa_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    //List myList = List.generate(50, (i) => i);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de -usuarios - SQLITE"),
      ),
      body: ListView(
        children: [
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
        ],
      ),
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
        });
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
        });
  }
}
