import 'dart:developer';

import '../adapter/company_adapter.dart';
import '../datasources/cnpj_datasources.dart';
import '../models/company_model.dart';

class CnpjRepository {
  final CnpjDatasource datasources;

  CnpjRepository(this.datasources);

  Future<CompanyModel> featchCompany(String cnpj) async {
    try {
      final result = await datasources.featchCompany(cnpj);

      final model = CompanyAdapter.fromJson(result);
      return model;
    } on Exception catch (e) {
      log(e.toString());
      throw Exception('Error: $e');
    }
  }
}
