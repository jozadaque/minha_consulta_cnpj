import 'package:minha_consulta_cnpj/models/company_model.dart';

class CompanyAdapter {
  static CompanyModel fromJsom(dynamic jsom) {
    return CompanyModel(
      name: jsom['razao_social'],
      size: jsom['porte'],
      legaceNature: jsom['natureza_juridica'],
      openingDate: jsom['data_inicio_atividade'],
      status: jsom['descricao_situacao_cadastral'],
    );
  }
}
