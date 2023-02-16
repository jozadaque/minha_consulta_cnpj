import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/datasources/cnpj_datasources.dart';
import 'package:minha_consulta_cnpj/repositories/i_search_cnpj_repository.dart';
import 'package:minha_consulta_cnpj/states/cnpj_search_state.dart';
import 'package:minha_consulta_cnpj/stores/cnpj_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final size = MediaQuery.of(context).size;
    CnpjStore store = CnpjStore(CnpjRepository(CnpjUno()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta CNPJ'),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text('CNPJ: '),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: controller,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        store.feacthCompany(controller.text);
                      },
                      child: const Text('Buscar')),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: store,
                builder: (_, value, child) {
                  log(value.toString());
                  if (value is LoadingState) {
                    log('Loading State');
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (value is ExceptionState) {
                    return const Center(child: Text('Falha no Pesquisa.'));
                  }
                  if (value is SucessState) {
                    log('Success State');
                    final company = value.company;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nome: ${company.name}'),
                          Text('Nome: ${company.size}'),
                          Text('Nome: ${company.status}'),
                          Text('Nome: ${company.legaceNature}'),
                          Text('Nome: ${company.openingDate}'),
                          Text('Nome: ${company.name}'),
                          Text('Nome: ${company.size}'),
                          Text('Nome: ${company.status}'),
                          Text('Nome: ${company.legaceNature}'),
                          Text('Nome: ${company.openingDate}'),
                          Text('Nome: ${company.name}'),
                          Text('Nome: ${company.size}'),
                          Text('Nome: ${company.status}'),
                          Text('Nome: ${company.legaceNature}'),
                          Text('Nome: ${company.openingDate}'),
                        ],
                      ),
                    );
                  }
                  if (value is InitialState) {
                    log('Initial State');
                    return const Center(child: Text('Informe a Empresa '));
                  }
                  log('None State');
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
