import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:minha_consulta_cnpj/app/datasources/cnpj_datasources.dart';
import 'package:minha_consulta_cnpj/app/exceptions/result_exceptions.dart';
import 'package:minha_consulta_cnpj/app/models/company_model.dart';
import 'package:minha_consulta_cnpj/app/repositories/i_search_cnpj_repository.dart';
import 'package:mocktail/mocktail.dart';

class Datasource extends Mock implements CnpjDatasource {}

void main() {
  Datasource datasources = Datasource();

  CnpjRepository repository = CnpjRepository(datasources);

  test('Should a CompanyModel', () async {
    when(() => datasources.featchCompany('cnpj'))
        .thenAnswer((_) async => jsonDecode(consult));

    final result = await repository.featchCompany('cnpj');
    expect(result, isA<CompanyModel>());
  });

  test('Should 12379016000136 to cnpj', () async {
    when(() => datasources.featchCompany('cnpj'))
        .thenAnswer((_) async => jsonDecode(consult));

    final result = await repository.featchCompany('cnpj');
    expect(result.cnpj, '12379016000136');
  });

  test('Should return a RepositoryException', () async {
    when(() => datasources.featchCompany('cnpj')).thenThrow(Exception());
    expect(() => repository.featchCompany('cnpj'),
        throwsA(isA<RepositoryException>()));
  });
}

const consult =
    '''{"uf":"SP","cep":"04913180","qsa":[],"cnpj":"12379016000136","pais":null,"email":null,"porte":"MICRO EMPRESA","bairro":"JARDIM SANTA EDWIGES (CAPELA DO SOCORRO)","numero":"615","ddd_fax":"","municipio":"SAO PAULO","logradouro":"INACIO DIAS DA SILVA","cnae_fiscal":4399103,"codigo_pais":null,"complemento":"","codigo_porte":1,"razao_social":"CRISTIANO SANTOS SOARES 18304809877","nome_fantasia":"","capital_social":2000,"ddd_telefone_1":"1187413290","ddd_telefone_2":"","opcao_pelo_mei":true,"descricao_porte":"","codigo_municipio":7107,"cnaes_secundarios":[{"codigo":4330405,"descricao":"Aplicação de revestimentos e de resinas em interiores e exteriores"}],"natureza_juridica":"Empresário (Individual)","situacao_especial":"","opcao_pelo_simples":true,"situacao_cadastral":2,"data_opcao_pelo_mei":"2010-08-14","data_exclusao_do_mei":null,"cnae_fiscal_descricao":"Obras de alvenaria","codigo_municipio_ibge":3550308,"data_inicio_atividade":"2010-08-14","data_situacao_especial":null,"data_opcao_pelo_simples":"2010-08-14","data_situacao_cadastral":"2010-08-14","nome_cidade_no_exterior":"","codigo_natureza_juridica":2135,"data_exclusao_do_simples":null,"motivo_situacao_cadastral":0,"ente_federativo_responsavel":"","identificador_matriz_filial":1,"qualificacao_do_responsavel":50,"descricao_situacao_cadastral":"ATIVA","descricao_tipo_de_logradouro":"AVENIDA","descricao_motivo_situacao_cadastral":"SEM MOTIVO","descricao_identificador_matriz_filial":"MATRIZ"}''';
