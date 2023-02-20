import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/services/validations.dart';
import 'package:minha_consulta_cnpj/states/cnpj_search_state.dart';
import 'package:minha_consulta_cnpj/stores/cnpj_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController cnpj = TextEditingController();
    final size = MediaQuery.of(context).size;
    CnpjStore store = context.watch<CnpjStore>();

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
                    child: Form(
                      key: _FormKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'O Campo CNPJ não pode ser vazio';
                          } else if (value.length < 14) {
                            return 'O CNPJ deve ter 14 digitos';
                          } else if (!Validations.cnpjValidator(value)) {
                            return 'O CNPJ informado não é valido';
                          }
                          return null;
                        },
                        controller: cnpj,
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
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
                        if (_FormKey.currentState!.validate()) {
                          store.feacthCompany(cnpj.text);
                        }
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
                          ]),
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
