
import 'package:flutter/material.dart';

import '../repositories/i_search_cnpj_repository.dart';
import '../states/cnpj_search_state.dart';

class CnpjStore extends ValueNotifier<CNPJSearchStates> {
  final CnpjRepository repository;

  CnpjStore(this.repository) : super(InitialState());

  Future feacthCompany(String cnpj) async {
    value = LoadingState();

    try {
      final company = await repository.featchCompany(cnpj);
      value = SucessState(company);
    } on Exception catch (e) {
      value = ExceptionState(e.toString());
    }
  }

  void newSearch() {
    value = InitialState();
  }
}
