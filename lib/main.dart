import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/app_widget.dart';
import 'pages/splash_screen.dart';

void main() async {
  runApp(const SplashScreen());
  Future.delayed(const Duration(seconds: 5), () => runApp(const AppWidget()));
}
