part of 'exporttoexcel_bloc.dart';

@immutable
abstract class ExporttoexcelState {}

class ExporttoexcelInitial extends ExporttoexcelState {}


class LoadingState extends ExporttoexcelState {}

class SheetExistsState extends ExporttoexcelState {}

class SuccessState extends ExporttoexcelState {}

class ErrorState extends ExporttoexcelState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  List<Object> get props => [errorMessage];
}