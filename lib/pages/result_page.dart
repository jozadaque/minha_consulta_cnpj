import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/models/company_model.dart';

class ResultPage extends StatelessWidget {
  final CompanyModel company;

  const ResultPage({super.key, required this.company});

  String dateConverter(String oldDate) => oldDate
      .split('-')
      .reversed
      .toString()
      .replaceAll(',', '/')
      .replaceAll('(', '')
      .replaceAll(')', '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.name),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const LabelTextWidget(label: 'Dados Gerais'),
              BodyTextWidget(
                dataCompany: [
                  'Nome: ${company.name.toTextFormat()}',
                  'Nome Fantasia: ${company.fantasyName.toTextFormat()}',
                  'CNPJ: ${company.cnpj}',
                  'Situação: ${company.status.toTextFormat()}',
                  'Natureza Juridica: ${company.legaceNatureCode} - ${company.legaceNature}',
                  'Data de Abertura: ${dateConverter(company.openingDate)}',
                  'Capital Social: ${company.initialMoney}',
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const LabelTextWidget(label: 'Endereço'),
              BodyTextWidget(dataCompany: [
                'Logradouro: ${company.publicPlaceDescription.toTextFormat()} ${company.publicPlace.toTextFormat()}',
                'Complemento: ${company.complement.toTextFormat()}',
                'Bairro: ${company.neighborhood.toTextFormat()}',
                'Cidade: ${company.city.toTextFormat()}',
                'UF: ${company.state}',
                'CEP: ${company.zipCode.toCepFormat()}',
              ]),
              const SizedBox(
                height: 15,
              ),
              const LabelTextWidget(label: 'Contatos'),
              BodyTextWidget(dataCompany: [
                'Telefone: ${company.phone1.toPhoneFormat()} ${company.phone2.toPhoneFormat()}',
                'E-mail: ${company.email}',
              ]),
              const SizedBox(
                height: 15,
              ),
              const LabelTextWidget(label: 'Atividade Principal'),
              ListTile(
                title: Text(
                  'CNAE: ${company.cnaeFiscalCode}',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                  child: Text(
                    'Atividade: ${company.cnaeFiscalDescription}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const LabelTextWidget(label: 'Atividades Secundárias'),
              Column(
                children: (company.secondActivities.isNotEmpty &&
                        company.secondActivities[0].code != 0)
                    ? List.generate(
                        company.secondActivities.length,
                        (index) => Column(
                              children: [
                                ListTile(
                                  minVerticalPadding: 3.0,
                                  title: Text(
                                      'CNAE: ${company.secondActivities[index].code}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, top: 4.0),
                                    child: Text(
                                        company.secondActivities[index]
                                            .description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ),
                                ),
                                const Divider()
                              ],
                            ))
                    : const [Text('Não há Atividades secundárias')],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class LabelTextWidget extends StatelessWidget {
  final String label;

  const LabelTextWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 1.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        const Divider(
          height: 7.0,
          thickness: 3.0,
        ),
      ],
    );
  }
}

class BodyTextWidget extends StatelessWidget {
  final List<String> dataCompany;

  const BodyTextWidget({super.key, required this.dataCompany});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
            dataCompany.length,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, left: 11.0),
                  child: Text(
                    dataCompany[index],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )),
      ),
    );
  }
}

extension on String {
  String toTextFormat() {
    if (isEmpty) {
      return this;
    }

    var output = '';
    split(' ').forEach((element) {
      output +=
          '${element[0].toUpperCase()}${element.substring(1).toLowerCase()} ';
    });
    output = output.trim();

    return output;
  }

  String toCepFormat() {
    if (isEmpty) {
      return this;
    }

    return '${substring(0, 5)}-${substring(5)}';
  }

  String toPhoneFormat() {
    if (isEmpty) {
      return this;
    }

    return '(${substring(0, 2)}) ${substring(2, 6)}-${substring(6)}';
  }
}
