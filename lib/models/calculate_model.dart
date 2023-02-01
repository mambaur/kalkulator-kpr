class CalculateModel {
  double? loan, year, interest;

  CalculateModel({this.loan, this.year, this.interest});
}

class CalculateResultModel {
  double? installmentResult, interestResult, principal;

  CalculateResultModel(
      {this.installmentResult, this.interestResult, this.principal});

  Map<String, dynamic> toJson() {
    return {
      "principal": principal,
      "interest": interestResult,
      "installment": (principal ?? 0) + (interestResult ?? 0)
    };
  }
}
