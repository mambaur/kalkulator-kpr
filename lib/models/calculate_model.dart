class CalculateModel {
  double? loanPlafon, loan, year, interest;

  double? fixInterest;
  double? fixYear;
  double? floatingInterest;

  CalculateModel(
      {this.loan,
      this.loanPlafon,
      this.year,
      this.interest,
      this.fixInterest,
      this.fixYear,
      this.floatingInterest});
}

class CalculateResultModel {
  double? installmentResult, interestResult, principal, principalTotalRemain;

  CalculateResultModel(
      {this.installmentResult,
      this.interestResult,
      this.principal,
      this.principalTotalRemain});
}

enum CalculatorType { flat, effective, anuitas }
