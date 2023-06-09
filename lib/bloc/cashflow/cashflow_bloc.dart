import 'dart:io';

import 'package:appbendaharaybi/models/cashflow_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/services.dart';

part 'cashflow_event.dart';
part 'cashflow_state.dart';

class CashflowBloc extends Bloc<CashflowEvent, CashflowState> {
  CashflowApiClient cashflowapi = CashflowApiClient();

  Stream<List<CashflowModel>> streamAlurDana() async* {
    while (true) {
      try {
        final List<CashflowModel> cashflowList =
            await cashflowapi.cashflowsget();
        yield cashflowList;
      } catch (e) {
        // Handle error case, such as yielding an empty list or throwing an exception
        yield [];
      }

      // Add a delay between API calls if necessary
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  CashflowBloc() : super(CashflowInitial()) {
    on<CashflowEventAdd>((event, emit) async {
      emit(CashflowLoading());
      try {
        await cashflowapi.cashflowsadd(event);
        emit(CashflowComplete());
      } catch (e) {
        emit(CashflowError("Tidak Bisa Menambah Cashflow"));
      }
    });
  }
}
