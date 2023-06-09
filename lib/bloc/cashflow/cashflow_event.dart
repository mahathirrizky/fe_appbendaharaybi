part of 'cashflow_bloc.dart';

@immutable
abstract class CashflowEvent {}

class CashflowEventAdd extends CashflowEvent {
  CashflowEventAdd({
    required this.jumlahdana,
    required this.keterangan,
    required this.jenis,
    this.image,
  });

  final int jumlahdana;
  final String keterangan;
  final String jenis;
  final File? image;
  
}

class CashflowEventEdit extends CashflowEvent {
  final int id;
  final String keterangan;
  final int jumlahdana;
  final String? imageUrl;
  final File? fileImage;

  CashflowEventEdit({
    required this.id,
    required this.keterangan,
    required this.jumlahdana,
    this.imageUrl,
    this.fileImage,
  });
}

class CashflowEventDelete extends CashflowEvent {
  final int id;
  CashflowEventDelete({required this.id}); 
}
