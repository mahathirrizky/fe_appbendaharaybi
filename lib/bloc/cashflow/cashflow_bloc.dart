import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cashflow_event.dart';
part 'cashflow_state.dart';

class CashflowBloc extends Bloc<CashflowEvent, CashflowState> {
  CashflowBloc() : super(CashflowInitial()) {
    on<CashflowEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
