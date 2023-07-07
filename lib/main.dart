import 'package:appsivalmattel/app/routes/routes_name.dart';
import 'package:appsivalmattel/app/routes/routes_view.dart';
import 'package:appsivalmattel/core/utils/injection_dependency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  InjectionDependency.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sival - Mattel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutesName.loginPage,
      //initialRoute: RoutesName.sincronizarPage,
      getPages: RoutesView.views,
    );
  }
}
