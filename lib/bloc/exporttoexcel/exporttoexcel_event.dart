part of 'exporttoexcel_bloc.dart';

@immutable
abstract class ExporttoexcelEvent {}

class ExporttoexcelEventCreate extends ExporttoexcelEvent {
  final List<CashflowModel> dataexport;

  ExporttoexcelEventCreate(this.dataexport);

}