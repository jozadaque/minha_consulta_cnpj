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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Dados Gerais'),
            const Divider(),
            Text('Nome: ${company.name}'),
            Text('Nome Fantasia: ${company.fantasyName}'),
            Text('CNPJ: ${company.cnpj}'),
            Text('Situação: ${company.status}'),
            Text(
                'Natureza Juridica: ${company.legaceNatureCode} - ${company.legaceNature}'),
            Text('Data de Abertura: ${dateConverter(company.openingDate)}'),
            Text('Capital Social: ${company.initialMoney}'),
            const SizedBox(
              height: 15,
            ),
            const Text('Endereço'),
            const Divider(),
            Text(
                'Logradouro: ${company.publicPlaceDescription} ${company.publicPlace}'),
            Text('Complemento: ${company.complement}'),
            Text('Bairro: ${company.neighborhood}'),
            Text('Cidade: ${company.city}'),
            Text('UF: ${company.state}'),
            Text('CEP: ${company.zipCode}'),
            const SizedBox(
              height: 15,
            ),
            const Text('Contatos'),
            const Divider(),
            Text('Telefone: ${company.phone1} ${company.phone2}'),
            Text('E-mail: ${company.email}'),
            const SizedBox(
              height: 15,
            ),
            const Text('Atividade Principal'),
            const Divider(),
            ListTile(
              title: Text('CNAE: ${company.cnaeFiscalCode}'),
              subtitle: Text('Atividade: ${company.cnaeFiscalDescription}'),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('Atividades Secundárias'),
            const Divider(),
            Column(
              children: company.secondActivities.isEmpty
                  ? List.generate(
                      company.secondActivities.length,
                      (index) => ListTile(
                            title: Text(company.secondActivities[index].code
                                .toString()),
                            subtitle: Text(
                                company.secondActivities[index].description),
                          ))
                  : const [Text('Não há Atividades secundárias')],
            )
          ]),
        ),
      ),
    );
  }
}
