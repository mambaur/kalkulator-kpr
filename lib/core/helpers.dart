import 'dart:math';

import 'package:kalkulator_kpr/models/calculate_model.dart';

// Jumlah pinjaman yang dihitung adalah pinjaman awal (plafon)
CalculateResultModel calculateFlat(CalculateModel calculateModel) {
  double month = calculateModel.year! * 12;
  double principal =
      (calculateModel.loanPlafon ?? calculateModel.loan!) / month;
  double interestResult =
      calculateModel.loan! * calculateModel.interest! * 0.01 / 12;

  return CalculateResultModel(
      installmentResult: principal + interestResult,
      principal: principal,
      interestResult: interestResult);
}

// Jumlah pinjaman yang dihitung adalah sisa pinjaman
CalculateResultModel calculateEffective(CalculateModel calculateModel) {
  double month = calculateModel.year! * 12;
  double principal =
      (calculateModel.loanPlafon ?? calculateModel.loan!) / month;
  double interestResult =
      calculateModel.loan! * calculateModel.interest! * 0.01 / 12;

  return CalculateResultModel(
      installmentResult: principal + interestResult,
      principal: principal,
      interestResult: interestResult);
}

CalculateResultModel calculateAnuitas(CalculateModel calculateModel) {
  double month = calculateModel.year! * 12;
  double annualInterest = calculateModel.interest! * 0.01 / 12;
  final interestIncrease = pow((1 + annualInterest), month);
  double installmentResult =
      ((calculateModel.loanPlafon ?? calculateModel.loan!) *
              annualInterest *
              interestIncrease) /
          (interestIncrease - 1);

  double interestResult = calculateModel.loan! * annualInterest;

  double principal = installmentResult - interestResult;

  return CalculateResultModel(
      installmentResult: installmentResult,
      principal: principal,
      interestResult: interestResult);
}

List<CalculateResultModel> installmentTableFlat(CalculateModel calculateModel) {
  int month = calculateModel.year!.toInt() * 12;
  double loan = calculateModel.loan!;

  List<CalculateResultModel> data = [];
  for (var i = 0; i < month; i++) {
    CalculateResultModel result = calculateFlat(calculateModel);
    loan = loan - result.principal!;
    result.principalTotalRemain = loan;
    // print(result.principalTotalRemain);
    data.add(result);

    // calculateModel.loan = result.principalTotalRemain;
  }
  return data;
}

List<CalculateResultModel> installmentTableEffective(
    CalculateModel calculateModel) {
  int month = calculateModel.year!.toInt() * 12;
  double loan = calculateModel.loan!;
  List<CalculateResultModel> data = [];

  for (var i = 0; i < month; i++) {
    CalculateResultModel result = calculateEffective(calculateModel);
    loan = loan - result.principal!;
    result.principalTotalRemain = loan;
    // print(result.principalTotalRemain);
    data.add(result);

    calculateModel.loan = result.principalTotalRemain;
  }

  return data;
}

List<CalculateResultModel> installmentTableAnuitas(
    CalculateModel calculateModel) {
  int month = calculateModel.year!.toInt() * 12;
  double loan = calculateModel.loan!;
  List<CalculateResultModel> data = [];

  for (var i = 0; i < month; i++) {
    CalculateResultModel result = calculateAnuitas(calculateModel);
    loan = loan - result.principal!;
    result.principalTotalRemain = loan;
    // print(result.interestResult);
    data.add(result);

    calculateModel.loan = result.principalTotalRemain;
  }

  return data;
}
