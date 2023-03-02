import '../models/company_model.dart';

abstract class CNPJSearchStates {}

class InitialState implements CNPJSearchStates {}

class LoadingState implements CNPJSearchStates {}

class SucessState implements CNPJSearchStates {
  final CompanyModel company;

  SucessState(this.company);
}

class ExceptionState implements CNPJSearchStates {
  final String message;

  ExceptionState(this.message);
}
