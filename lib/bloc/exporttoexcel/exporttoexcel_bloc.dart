import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/models.dart';

part 'exporttoexcel_event.dart';
part 'exporttoexcel_state.dart';

class ExporttoexcelBloc extends Bloc<ExporttoexcelEvent, ExporttoexcelState> {
  ExporttoexcelBloc() : super(ExporttoexcelInitial()) {
    on<ExporttoexcelEventCreate>((event, emit) async {
      try {
        emit(LoadingState());

        // Request the storage permission
        final status = await Permission.storage.request();

        if (status.isGranted) {
          // Permission granted, proceed with file saving

          // Create a new Excel workbook and sheet
          final excel = Excel.createExcel();
          final sheet = excel['sheetName'];

          // Add headers to the sheet
          sheet.appendRow(
              ['Nomer', 'Keterangan', 'Jumlah Dana', 'Jenis', 'Tanggal']);

          // Add data rows to the sheet
          for (final cashflow in event.dataexport) {
            final rowIndex = event.dataexport.indexOf(cashflow) + 1;
            sheet.appendRow([
              rowIndex,
              cashflow.keterangan,
              cashflow.jumlah,
              cashflow.jenis,
              DateFormat('dd-MM-yyyy').format(cashflow.createdAt),
            ]);
          }

          final Directory appDocumentsDir =
              await getApplicationDocumentsDirectory();
          print(appDocumentsDir);
          final directoryPath = appDocumentsDir.path;
          print(directoryPath);
          final filePath = '$directoryPath/cashflow_data.xlsx';
          print(filePath);
          final file = File(filePath);
          final encodedExcel = excel.encode();
          // file.writeAsBytes(encodedExcel!);
          if (encodedExcel != null) {
            try {
              await file.writeAsBytes(encodedExcel);
              emit(SuccessState());
            } catch (e) {
              emit(ErrorState('Failed to write Excel file: $e'));
            }
          } else {
            emit(ErrorState('Failed to encode Excel file.'));
          }
        } else {
          // Permission denied, emit an error state
          emit(ErrorState('Storage permission denied.'));
        }
      } catch (e) {
        emit(ErrorState('Failed to Create Excel file.'));
      }
    });
  }
}
