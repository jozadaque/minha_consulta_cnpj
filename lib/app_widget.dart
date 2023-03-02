import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/pages/home_page.dart';
import 'package:minha_consulta_cnpj/providers.dart';
import 'package:provider/provider.dart';

import 'themes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Busca CNPJ',
        debugShowCheckedModeBanner: false,
        theme: myThemes,
        home: const HomePage(),
      ),
    );
  }
}
