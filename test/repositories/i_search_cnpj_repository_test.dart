import 'package:flutter_test/flutter_test.dart';
import 'package:minha_consulta_cnpj/datasources/cnpj_datasources.dart';
import 'package:minha_consulta_cnpj/repositories/i_search_cnpj_repository.dart';

void main() {
  test('Should return a J S SOUSA to datasource CNPJUNO', () async {
    final CnpjRepository repository = CnpjRepository(CnpjUno());

    final result = await repository.featchCompany('46872135000148');
    expect(result.name, 'J S SOUSA');
  });

  test('Should return a J S SOUSA to datasource CNPJDIO', () async {
    final CnpjRepository repository = CnpjRepository(CnpjDio());

    final result = await repository.featchCompany('46872135000148');
    expect(result.name, 'J S SOUSA');
  });
}
