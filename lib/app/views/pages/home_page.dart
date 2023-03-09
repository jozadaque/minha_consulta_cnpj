import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/app/views/pages/result_page.dart';
import 'package:minha_consulta_cnpj/app/services/validations.dart';
import 'package:minha_consulta_cnpj/app/states/cnpj_search_state.dart';
import 'package:minha_consulta_cnpj/app/stores/cnpj_store.dart';
import 'package:provider/provider.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

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

  limpaCNPJ(String value) =>
      value.replaceAll('.', '').replaceAll('/', '').replaceAll('-', '');

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
                if (value is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (value is ExceptionState) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/error.png', width: 100),
                      const SizedBox(height: 30),
                      Text(
                        'Falha na Pesquisa.',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        width: size.width,
                        height: size.height * 0.06,
                        child: ElevatedButton(
                            onPressed: () {
                              store.newSearch();
                              cnpj.clear();
                            },
                            child: const Text('Nova Pesquisa')),
                      )
                    ],
                  ));
                }
                if (value is SucessState) {
                  final company = value.company;
                  cnpj.clear();
                  Future.delayed(
                      const Duration(milliseconds: 50),
                      () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => ResultPage(
                                company: company,
                                store: store,
                              ),
                            ),
                          ));
                }
                //    if (value is InitialState) {

                return Center(
                  child: SizedBox(
                    width: size.width,
                    child: SingleChildScrollView(
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
                                  } else if (value.length < 18) {
                                    return 'O CNPJ deve ter 18 digitos';
                                  } else if (!Validations.cnpjValidator(
                                      value)) {
                                    String imputValue = limpaCNPJ(value);

                                    if (!Validations.cnpjValidator(
                                        imputValue)) {
                                      return 'O CNPJ informado não é valido';
                                    }

                                    return null;
                                  }
                                  return null;
                                },
                                controller: cnpj,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                maxLength: 18,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CnpjInputFormatter(),
                                ],
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
                                      String inputValue = limpaCNPJ(cnpj.text);
                                      store.feacthCompany(inputValue);
                                    }
                                  },
                                  child: const Text('Buscar')),
                            ),
                          ]),
                    ),
                  ),
                );
                //    }
              },
            ),
          ),
        ));
  }
}
