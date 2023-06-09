import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

StreamBuilder<List<CashflowModel>> streambuildertopcard(
    CashflowBloc alurdanaB) {
  return StreamBuilder<List<CashflowModel>>(
    stream: alurdanaB.streamAlurDana(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (!snapshot.hasData) {
        return const Center(
          child: Text(""),
        );
      }
      if (snapshot.hasError) {
        return const Center(
          child: Text("Tidak dapat mengambil data"),
        );
      }
      List<int> umasuk = [];
      List<int> ukeluar = [];
      if (snapshot.data!.isNotEmpty) {
        snapshot.data!.forEach((element) {
          element.jenis == 'danamasuk'
              ? umasuk.add(element.jumlah)
              : ukeluar.add(element.jumlah);
        });
      }
      int totalmasuk =
          snapshot.data!.isNotEmpty ? umasuk.fold(0, (p, c) => p + c) : 0;

      int totalkeluar =
          snapshot.data!.isNotEmpty ? ukeluar.fold(0, (p, c) => p + c) : 0;

      int saldo = totalmasuk - totalkeluar;

      int uangmasuk = snapshot.data!.isNotEmpty ? umasuk.first : 0;
      int uangkeluar = snapshot.data!.isNotEmpty ? ukeluar.first : 0;

      return TopNewCard(
        saldo: saldo.toString(),
        danakeluar: uangkeluar.toString(),
        danamasuk: uangmasuk.toString(),
      );
    },
  );
}
