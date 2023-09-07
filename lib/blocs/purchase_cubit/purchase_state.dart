part of 'purchase_cubit.dart';

@immutable
class PurchaseState {}

class PurchaseInitial extends PurchaseState {}

class PurchaseData extends PurchaseState {
  final CustomerInfo? customerInfo;
  final bool isPremium;

  PurchaseData({this.customerInfo, this.isPremium = false});
}

class PurchaseNothing extends PurchaseState {}

class PurchaseError extends PurchaseState {}
