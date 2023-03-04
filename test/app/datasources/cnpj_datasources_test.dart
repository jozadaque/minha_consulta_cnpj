import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:minha_consulta_cnpj/app/datasources/cnpj_datasources.dart';
import 'package:minha_consulta_cnpj/app/exceptions/result_exceptions.dart';

void main() {
  final Dio dio = Dio();
  final DioAdapter dioAdapter = DioAdapter(dio: dio);
  dio.httpClientAdapter = dioAdapter;
  String cnpj = "46872135000148";
  final datasource = CnpjDio(dio);

  test('Should return a Map', () async {
    dioAdapter.onGet('https://brasilapi.com.br/api/cnpj/v1/$cnpj',
        (request) => request.reply(200, {}, delay: const Duration(seconds: 1)));

    final result = await datasource.featchCompany(cnpj);

    expect(result, isA<Map>());
  });

  test('Should return a ExceptionNotFounded to exception not expected', () {
    dioAdapter.onGet('https://brasilapi.com.br/api/cnpj/v1/$cnpj',
        (request) => request.reply(0, {}, delay: const Duration(seconds: 1)));

    final result = datasource.featchCompany(cnpj);

    expect(result, throwsA(isA<ExceptionNotFounded>()));
  });

  test('Should return a Exception404 when status code is 404', () {
    dioAdapter.onGet('https://brasilapi.com.br/api/cnpj/v1/$cnpj',
        (request) => request.reply(404, {}, delay: const Duration(seconds: 1)));

    final result = datasource.featchCompany(cnpj);

    expect(result, throwsA(isA<Exception404>()));
  });
}
