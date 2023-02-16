import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:uno/uno.dart';

abstract class CnpjDatasource {
  Future<dynamic> featchCompany(String cnpj);
}

class CnpjUno implements CnpjDatasource {
  final Uno datasource = Uno();

  @override
  Future<Map<dynamic, dynamic>> featchCompany(String cnpj) async {
    final response =
        await datasource.get('https://receitaws.com.br/v1/cnpj/$cnpj');
    log(response.status.toString());
    return response.data;
  }
}

class CnpjDio implements CnpjDatasource {
  final Dio datasource = Dio();

  @override
  Future<Map<dynamic, dynamic>> featchCompany(String cnpj) async {
    final response =
        await datasource.get('https://receitaws.com.br/v1/cnpj/$cnpj');
    return response.data;
  }
}
