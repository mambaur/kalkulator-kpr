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
    data.add(result);
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
    data.add(result);

    calculateModel.loan = result.principalTotalRemain;
  }

  return data;
}

List<CalculateResultModel> installmentTableFixFloating(
    CalculatorType type, CalculateModel calculateModel) {
  List<CalculateResultModel> data = [];

  double loan = calculateModel.loan!;
  final totalMonths = calculateModel.year! * 12;
  final fixMonths =
      calculateModel.fixYear != null ? calculateModel.fixYear! * 12 : 0;
  final floatingMonths = totalMonths - fixMonths;

  // === Periode FIX ===
  for (int i = 0; i < fixMonths; i++) {
    calculateModel.interest = calculateModel.fixInterest;
    CalculateResultModel result = type == CalculatorType.anuitas
        ? calculateAnuitas(calculateModel)
        : calculateEffective(calculateModel);
    loan = loan - result.principal!;
    result.principalTotalRemain = loan;
    data.add(result);

    calculateModel.loan = result.principalTotalRemain;
  }

  calculateModel.loanPlafon = calculateModel.loan!;
  calculateModel.year = calculateModel.year! - calculateModel.fixYear!;
  calculateModel.interest = calculateModel.floatingInterest;

  // === Periode FLOATING ===
  for (int i = 0; i < floatingMonths; i++) {
    CalculateResultModel result = type == CalculatorType.anuitas
        ? calculateAnuitas(calculateModel)
        : calculateEffective(calculateModel);
    loan = loan - result.principal!;
    result.principalTotalRemain = loan;
    data.add(result);

    calculateModel.loan = result.principalTotalRemain;
  }

  return data;
}

List<CalculateResultModel> installmentTableTiered(CalculatorType type,
    CalculateModel calculateModel, List<double> tieredInterest) {
  List<CalculateResultModel> data = [];

  calculateModel.fixYear = tieredInterest.length.toDouble();

  double loan = calculateModel.loan!;
  final totalMonths = calculateModel.year! * 12;
  final fixMonths =
      calculateModel.fixYear != null ? calculateModel.fixYear! * 12 : 0;
  final floatingMonths = totalMonths - fixMonths;

  // === Periode FIX ===
  for (var j = 0; j < tieredInterest.length; j++) {
    for (int i = 0; i < 12; i++) {
      calculateModel.interest = tieredInterest[j];
      CalculateResultModel result = type == CalculatorType.anuitas
          ? calculateAnuitas(calculateModel)
          : calculateEffective(calculateModel);
      loan = loan - result.principal!;
      result.principalTotalRemain = loan;
      data.add(result);

      calculateModel.loan = result.principalTotalRemain;
    }
    calculateModel.loanPlafon = calculateModel.loan!;
    calculateModel.year = calculateModel.year! - 1;
  }

  calculateModel.loanPlafon = calculateModel.loan!;
  calculateModel.interest = calculateModel.floatingInterest;

  // === Periode FLOATING ===
  for (int i = 0; i < floatingMonths; i++) {
    CalculateResultModel result = type == CalculatorType.anuitas
        ? calculateAnuitas(calculateModel)
        : calculateEffective(calculateModel);
    loan = loan - result.principal!;
    result.principalTotalRemain = loan;
    data.add(result);

    calculateModel.loan = result.principalTotalRemain;
  }

  return data;
}
