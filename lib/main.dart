import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/app/app_widget.dart';
import 'app/views/pages/splash_screen.dart';

void main() async {
  runApp(const SplashScreen());
  Future.delayed(const Duration(seconds: 5), () => runApp(const AppWidget()));
}
