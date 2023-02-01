import 'package:kalkulator_kpr/models/calculate_model.dart';

CalculateResultModel calculateFlat(CalculateModel calculateModel) {
  double month = calculateModel.year! * 12;
  double principal = calculateModel.loan! / month;
  double interestResult = calculateModel.loan! *
      calculateModel.year! *
      calculateModel.interest! *
      0.01 /
      month;

  return CalculateResultModel(
      installmentResult: principal + interestResult,
      principal: principal,
      interestResult: interestResult);
}
