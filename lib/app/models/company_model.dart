import '../adapter/company_adapter.dart';

class CompanyModel {
  final String name;
  final String fantasyName;
  final String cnpj;
  final String legaceNature;
  final int legaceNatureCode;
  final String openingDate;
  final String status;
  final int initialMoney;
  final String publicPlace;
  final String publicPlaceDescription;
  final String number;
  final String neighborhood;
  final String complement;
  final String zipCode;
  final String state;
  final String city;
  final String phone1;
  final String phone2;
  final String email;
  final String cnaeFiscalDescription;
  final int cnaeFiscalCode;
  final List<ActivityAdapter> secondActivities;

  CompanyModel({
    required this.name,
    required this.fantasyName,
    required this.cnpj,
    required this.legaceNature,
    required this.legaceNatureCode,
    required this.openingDate,
    required this.status,
    required this.initialMoney,
    required this.publicPlace,
    required this.publicPlaceDescription,
    required this.number,
    required this.neighborhood,
    required this.complement,
    required this.zipCode,
    required this.state,
    required this.city,
    required this.phone1,
    required this.phone2,
    required this.email,
    required this.cnaeFiscalDescription,
    required this.cnaeFiscalCode,
    required this.secondActivities,
  });
}

class ActivityModel {
  final dynamic code;
  final dynamic description;

  ActivityModel({
    required this.code,
    required this.description,
  });
}
