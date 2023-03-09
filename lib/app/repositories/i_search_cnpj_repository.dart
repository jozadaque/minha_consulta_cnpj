import '../adapter/company_adapter.dart';
import '../datasources/cnpj_datasources.dart';
import '../exceptions/result_exceptions.dart';
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
      throw RepositoryException('Error: $e');
    }
  }
}
