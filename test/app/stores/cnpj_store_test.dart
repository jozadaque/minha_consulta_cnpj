import 'package:flutter_test/flutter_test.dart';
import 'package:minha_consulta_cnpj/app/models/company_model.dart';
import 'package:minha_consulta_cnpj/app/repositories/i_search_cnpj_repository.dart';
import 'package:minha_consulta_cnpj/app/states/cnpj_search_state.dart';
import 'package:minha_consulta_cnpj/app/stores/cnpj_store.dart';
import 'package:mocktail/mocktail.dart';

class Repository extends Mock implements CnpjRepository {}

class CompanyMock extends Mock implements CompanyModel {}

void main() {
  final Repository repository = Repository();
  final CnpjStore store = CnpjStore(repository);
  final CompanyMock company = CompanyMock();

  test('Should return a SuccessState', () async {
    when(() => repository.featchCompany('')).thenAnswer((_) async => company);

    await store.feacthCompany('');

    expect(store.value, isA<SucessState>());
  });

  test('Should return a InitialState', () {
    store.newSearch();
    expect(store.value, isA<InitialState>());
  });

  test('Should return a ExceptionState', () async {
    when(() => repository.featchCompany('')).thenThrow(Exception());

    await store.feacthCompany('');

    expect(store.value, isA<ExceptionState>());
  });
}
