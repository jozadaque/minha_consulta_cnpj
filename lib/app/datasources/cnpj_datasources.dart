import 'package:dio/dio.dart';
import '../exceptions/result_exceptions.dart';

abstract class CnpjDatasource {
  Future<dynamic> featchCompany(String cnpj);
}

class CnpjDio implements CnpjDatasource {
  final Dio dio;

  CnpjDio(this.dio);

  @override
  Future<Map<dynamic, dynamic>> featchCompany(String cnpj) async {
    try {
      final response =
          await dio.get('https://brasilapi.com.br/api/cnpj/v1/$cnpj');
      return response.data;
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        throw Exception404();
      }
      throw ExceptionNotFounded();
    }
  }
}
