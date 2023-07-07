import 'package:appsivalmattel/app/ui/views/sincronizar/sincronizar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SincronizarView extends StatelessWidget {
  const SincronizarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SincronizarController>(
      init: SincronizarController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Sincronizar"),
          ),
          body: ListView.builder(
            itemCount: controller.distribuidoras.length,
            itemBuilder: (context, index) {
              //return ListTile(
              //  leading: CircleAvatar(
              //    child: Text("${usuarios[index].id}"),
              // ),
              //  title: Text(usuarios[index].nombre),
              //);
              //return ListTile(
              //  leading: CircleAvatar(
              //    child: Text("${puntoventas[index].id}"),
              //  ),
              //  title: Text(puntoventas[index].nombre),
              //  subtitle: Text(puntoventas[index].idcadena),
              //);
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${controller.distribuidoras[index].id}"),
                ),
                title: Text(controller.distribuidoras[index].nombre),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.getAllSqlite();
            },
            child: const Icon(Icons.list),
          ),
        );
      },
    );
  }
}
