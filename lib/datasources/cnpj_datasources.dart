import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:uno/uno.dart';

abstract class CnpjDatasource {
  Future<dynamic> featchCompany(String cnpj);
}

class CnpjUno implements CnpjDatasource {
  final Uno uno;

  CnpjUno(this.uno);

  @override
  Future<Map<dynamic, dynamic>> featchCompany(String cnpj) async {
    final response =
        await uno.get('https://brasilapi.com.br/api/cnpj/v1/$cnpj');
    log(response.status.toString());
    return response.data;
  }
}

class CnpjDio implements CnpjDatasource {
  final Dio dio;

  CnpjDio(this.dio);

  @override
  Future<Map<dynamic, dynamic>> featchCompany(String cnpj) async {
    final response =
        await dio.get('https://brasilapi.com.br/api/cnpj/v1/$cnpj');
    return response.data;
  }
}
