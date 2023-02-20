import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/repositories/i_search_cnpj_repository.dart';
import 'package:minha_consulta_cnpj/stores/cnpj_store.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';
import 'datasources/cnpj_datasources.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Uno()),
        Provider<CnpjDatasource>(create: (context) => CnpjUno(context.read())),
        Provider(create: (context) => CnpjRepository(context.read())),
        ChangeNotifierProvider(create: (context) => CnpjStore(context.read()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
