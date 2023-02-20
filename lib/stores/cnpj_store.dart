import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:minha_consulta_cnpj/repositories/i_search_cnpj_repository.dart';
import '../states/cnpj_search_state.dart';

class CnpjStore extends ValueNotifier<CNPJSearchStates> {
  final CnpjRepository repository;

  CnpjStore(this.repository) : super(InitialState());

  Future feacthCompany(String cnpj) async {
    value = LoadingState();

    try {
      final company = await repository.featchCompany(cnpj);
      log(company.name);
      value = SucessState(company);
    } on Exception catch (e) {
      value = ExceptionState(e.toString());
    }
  }
}