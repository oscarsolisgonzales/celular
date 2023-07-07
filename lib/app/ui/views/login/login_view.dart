import 'package:appsivalmattel/app/ui/views/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//cambio11

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/fondo.png",
                ),
                fit: BoxFit.cover),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              children: [
                const SizedBox(height: 270),
                const Center(
                  child: Text(
                    "Ingreso al Sistema",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "Version 10.0",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                _txtemail(controller),
                const SizedBox(height: 20),
                _txtpassword(controller),
                const SizedBox(height: 20),
                _btnaceptar(context, controller),
                const SizedBox(height: 15),
                _btnsincronizar(context, controller),
                const SizedBox(height: 15),
                _btnSalir(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _txtemail(controller) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        //hintText: "Email",
        labelText: "Email",
        suffixIcon: Icon(Icons.alternate_email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onChanged: (value) {
        controller.txtemail = value;
      },
    );
  }

  Widget _txtpassword(controller) {
    return TextField(
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      obscureText: true,
      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Password",
        labelText: "Password",
        suffixIcon: Icon(Icons.lock_clock_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onChanged: (value) {
        controller.txtpassword = value;
      },
    );
  }

  Widget _btnsincronizar(context, controller) {
    return MaterialButton(
      onPressed: () {
        controller.goToSincronizar();
      },
      //elevation: 10.0,
      minWidth: 170.0,
      height: 50.0,
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 7.0,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Sincronizar",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          SizedBox(width: 20),
          Icon(Icons.cloud_download, color: Colors.white, size: 24.0),
        ],
      ),
    );
  }

  Widget _btnaceptar(context, controller) {
    return MaterialButton(
      onPressed: () {
        controller.getUsuario();
      },
      //elevation: 10.0,
      minWidth: 170.0,
      height: 50.0,
      color: Theme.of(context).primaryColor,
      elevation: 7.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: const Text(
        "Ingresar",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }

  Widget _btnSalir() {
    return MaterialButton(
      onPressed: () {},
      //elevation: 10.0,
      minWidth: 170.0,
      height: 50.0,
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 7.0,
      child: const Text(
        "Salir",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    );
  }

/*   void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Usuario o Password incorrecto")],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  } */
}
