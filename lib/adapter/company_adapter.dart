import 'package:minha_consulta_cnpj/models/company_model.dart';

class CompanyAdapter {
  static CompanyModel fromJson(dynamic json) {
    final cnaes = json['cnaes_secundarios'] as List;
    return CompanyModel(
      name: json['razao_social'] ?? '',
      fantasyName: json['nome_fantasia'] ?? '',
      cnpj: json['cnpj'] ?? '',
      legaceNature: json['natureza_juridica'] ?? '',
      openingDate: json['data_inicio_atividade'] ?? '',
      status: json['descricao_situacao_cadastral'] ?? '',
      legaceNatureCode: json['codigo_natureza_juridica'] ?? '',
      initialMoney: json['capital_social'] ?? '',
      publicPlace: json['logradouro'] ?? '',
      publicPlaceDescription: json['descricao_tipo_de_logradouro'] ?? '',
      neighborhood: json['bairro'] ?? '',
      number: json['numero'] ?? '',
      complement: json['complemento'] ?? '',
      zipCode: json['cep'] ?? '',
      state: json['uf'] ?? '',
      city: json['municipio'] ?? '',
      phone1: json['ddd_telefone_1'] ?? '',
      phone2: json['ddd_telefone_2'] ?? '',
      email: json['email'] ?? '',
      cnaeFiscalDescription: json['cnae_fiscal_descricao'] ?? '',
      cnaeFiscalCode: json['cnae_fiscal'] ?? '',
      secondActivities: cnaes.map(ActivityAdapter.fromJson).toList(),
    );
  }
}

class ActivityAdapter extends ActivityModel {
  ActivityAdapter({
    required super.code,
    required super.description,
  });

  factory ActivityAdapter.fromJson(dynamic json) {
    return ActivityAdapter(
      code: json['codigo'],
      description: json['descricao'],
    );
  }
}
