import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/pages/result_page.dart';
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
  final _formKey = GlobalKey<FormState>();
  TextEditingController cnpj = TextEditingController();

  @override
  void dispose() {
    cnpj.clear();
    cnpj.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    CnpjStore store = context.watch<CnpjStore>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Consulta CNPJ'),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: ValueListenableBuilder(
              valueListenable: store,
              builder: (_, value, child) {
                log(value.toString());
                if (value is LoadingState) {
                  log('Loading State');
                  return const Center(child: CircularProgressIndicator());
                }
                if (value is ExceptionState) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Falha no Pesquisa.'),
                      ElevatedButton(
                          onPressed: () {
                            store.newSearch();
                            cnpj.clear();
                          },
                          child: const Text('Nova Pesquisa'))
                    ],
                  ));
                }
                if (value is SucessState) {
                  log('Success State');
                  final company = value.company;
                  Future.delayed(
                      const Duration(milliseconds: 50),
                      () => Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ResultPage(
                                company: company,
                              ),
                            ),
                          ));
                }
                //    if (value is InitialState) {
                log('Initial State');
                return Center(
                  child: SizedBox(
                    width: size.width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // const Text('CNPJ: '),
                          Image.asset('assets/images/magnifying_glass.png',
                              height: size.height * 0.35),
                          Form(
                            key: _formKey,
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
                              maxLength: 14,
                              decoration: const InputDecoration(
                                  label: Text('Infome seu CNPJ'),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.06,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    store.feacthCompany(cnpj.text);
                                    //store.feacthCompany('19131243000197');
                                  }
                                },
                                child: const Text('Buscar')),
                          ),
                        ]),
                  ),
                );
                //    }
              },
            ),
          ),
        ));
  }
}
