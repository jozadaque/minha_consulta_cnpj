import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:minha_consulta_cnpj/datasources/cnpj_datasources.dart';
import 'package:minha_consulta_cnpj/repositories/i_search_cnpj_repository.dart';
import 'package:minha_consulta_cnpj/stores/cnpj_store.dart';
import 'package:uno/uno.dart';

void main() {
  test('Should return a J S SOUSA to datasource CNPJUNO', () async {
    CnpjStore state = CnpjStore(CnpjRepository(CnpjUno(Uno())));

    final result = await state.feacthCompany('46872135000148');

    expect(result.name, 'J S SOUSA');
  });

  test('Should return a J S SOUSA to datasource CNPJDIO', () async {
    CnpjStore state = CnpjStore(CnpjRepository(CnpjDio(Dio())));

    final result = await state.feacthCompany('46872135000148');
    expect(result.name, 'J S SOUSA');
  });
}
