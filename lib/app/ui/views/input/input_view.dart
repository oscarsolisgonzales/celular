import 'package:appsivalmattel/app/ui/views/input/input_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputView extends StatelessWidget {
  const InputView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputController>(
      init: InputController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Input"),
          ),
          backgroundColor: Colors.white,
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            children: [
              const SizedBox(height: 20),
              _texto("Ingrese Nombre"),
              _inputText(),
            ],
          ),
        );
      },
    );
  }

  Widget _inputText() {
    return const TextField(
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: "Nombre",
        filled: true,
        fillColor: Color.fromARGB(255, 221, 237, 245),
      ),
    );
  }

  Widget _texto(String texto) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 18.0),
    );
  }
}
