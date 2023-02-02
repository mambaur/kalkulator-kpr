class CalculateModel {
  double? loanPlafon, loan, year, interest;

  CalculateModel({this.loan, this.loanPlafon, this.year, this.interest});
}

class CalculateResultModel {
  double? installmentResult, interestResult, principal, principalTotalRemain;

  CalculateResultModel(
      {this.installmentResult,
      this.interestResult,
      this.principal,
      this.principalTotalRemain});

  Map<String, dynamic> toJson() {
    return {
      "principal": principal,
      "interest": interestResult,
      "installment": (principal ?? 0) + (interestResult ?? 0)
    };
  }
}

enum CalculatorType { flat, effective, anuitas }
