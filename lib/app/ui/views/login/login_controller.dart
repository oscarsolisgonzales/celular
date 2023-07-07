import 'package:appsivalmattel/app/data/providers/usuario_provider.dart';
import 'package:appsivalmattel/app/routes/routes_name.dart';
import 'package:appsivalmattel/app/services/storage/storage_service.dart';
import 'package:appsivalmattel/core/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/response/response_usuario_model.dart';

class LoginController extends GetxController {
  //Instance
  @override
  void onInit() {
    inicialize();
    super.onInit();
  }

  //Variables

  UsuarioProvider usuarioProvider = UsuarioProvider();
  List<ResponseUsuarioModel> usuarios = [];

  String txtemail = "";
  String txtpassword = "";
  int cantidad = 0;
  String userMail = "";

  //Functions
  inicialize() async {
    txtemail = await StorageService.get(Keys.keyUserEmail);
  }

  goToHome() {
    Get.offNamed(RoutesName.homePage);
  }

  goToSincronizar() {
    Get.toNamed(RoutesName.sincronizarPage);
  }

  getUsuario() async {
    final response = await ResponseUsuarioModel().query(
        "WHERE email=? AND password=?",
        arguments: [txtemail, txtpassword]);

    usuarios = (response as List)
        .map(
          (data) => ResponseUsuarioModel.fromJson(data),
        )
        .toList();

    cantidad = usuarios.length;

    if (cantidad > 0) {
      await StorageService.set(
        key: Keys.keyUserId,
        value: usuarios[0].id.toString(),
      );
      await StorageService.set(
        key: Keys.keyUserNombre,
        value: usuarios[0].nombre,
      );
      await StorageService.set(
        key: Keys.keyUserEmail,
        value: usuarios[0].email,
      );
      goToHome();
    } else {
      Get.snackbar(
        "Error en Autenticación",
        "Usuario o Password mal ingresados... por Favor Verificar",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error_outline),
        colorText: Colors.white,
        backgroundColor: Colors.lightBlue,
        duration: const Duration(seconds: 4),
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
        showProgressIndicator: true,
      );
    }
  }
}
