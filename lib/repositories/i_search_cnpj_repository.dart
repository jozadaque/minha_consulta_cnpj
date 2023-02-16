import 'package:minha_consulta_cnpj/adapter/company_adapter.dart';

import '../datasources/cnpj_datasources.dart';
import '../models/company_model.dart';

class CnpjRepository {
  final CnpjDatasource datasources;

  CnpjRepository(this.datasources);

  Future<CompanyModel> featchCompany(String cnpj) async {
    final result = await datasources.featchCompany(cnpj);

    final model = CompanyAdapter.fromJsom(result);
    return model;
  }
}
