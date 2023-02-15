import 'package:minha_consulta_cnpj/models/company_model.dart';

class CompanyAdapter {
  static CompanyModel fromJsom(dynamic jsom) {
    return CompanyModel(
      name: jsom['nome'],
      size: jsom['porte'],
      legaceNature: jsom['natureza_juridica'],
      openingDate: jsom['abertura'],
      status: jsom['situacao'],
    );
  }
}
