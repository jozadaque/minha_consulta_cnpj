class Validations {
  static bool cnpjValidator(String cnpj) {
    if (int.tryParse(cnpj) == null) {
      return false;
    }

    bool validDigit1 =
        _digitValidator(cnpj, [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])
                .toString() ==
            cnpj.substring(12, 13);
    bool validDigit2 =
        _digitValidator(cnpj, [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])
                .toString() ==
            cnpj.substring(13);

    return (validDigit1 && validDigit2);
  }

  static _digitValidator(String value, List<int> validatorList) {
    late int sum = 0;
    int i = 0;
    value
        .substring(0, validatorList.length)
        .split('')
        .map((e) => int.parse(e))
        .toList()
        .forEach((element) {
      sum += element * validatorList[i];
      i++;
    });

    if (sum % 11 < 2) {
      return 0;
    } else {
      return (11 - (sum % 11));
    }
  }
}
