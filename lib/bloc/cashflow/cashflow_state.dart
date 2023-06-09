part of 'cashflow_bloc.dart';

@immutable
abstract class CashflowState {}

class CashflowInitial extends CashflowState {}

class CashflowLoading extends CashflowState {}

class CashflowComplete extends CashflowState {}

class CashflowError extends CashflowState {
  CashflowError(this.message);

  final String message;
}

// class CashflowFirst extends class CashflowError extendsCashflowState {
//  {
//   CashflowFirst(this.firstdanamasuk);
//   final List<Alurdana> firstdanamasuk;
// }