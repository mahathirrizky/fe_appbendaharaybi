import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

StreamBuilder<List<CashflowModel>> streambuilderexport(
    CashflowBloc alurdanaB, int bulanaktif, tahunaktif) {
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

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Expanded(
            child: Center(
              child: Text("Tidak ada data"),
            ),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Tidak dapat mengambil data"),
          );
        }

        List<CashflowModel> allAlurdana = [];
        snapshot.data!.forEach((element) {
          allAlurdana.add(element);
        });
        final tahun = allAlurdana.where((y) => y.createdAt.year == tahunaktif);
        if (tahun.isEmpty) {
          return const Expanded(
            child: Center(
              child: Text("Tidak ada data"),
            ),
          );
        }

        int totalm = 0;
        int totalk = 0;
        int total = 0;
        String totalmk;
        for (int i = 0; i <= bulanaktif + 1; i++) {
          for (var element in tahun
              .where((d) => d.createdAt.month == i)
              .where((da) => da.jenis == 'danamasuk')) {
            totalm += element.jumlah;
          }
          for (var element in tahun
              .where((d) => d.createdAt.month == i)
              .where((da) => da.jenis == 'danakeluar')) {
            totalk += element.jumlah;
          }
          total = totalm - totalk;
        }
        totalmk = FormatCurrency.convertToIdr(total, 0);
        print(total);
        final seluruhalurdana =
            tahun.where((d) => d.createdAt.month == bulanaktif + 1).toList();
        if (seluruhalurdana.isEmpty) {
          return const Expanded(
            child: Center(
              child: Text("Tidak ada data"),
            ),
          );
        }

        final bulantotal = DateFormat('MMM')
            .format(DateTime(0, seluruhalurdana[0].createdAt.month));

        return seluruhalurdana.isNotEmpty
            ? Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total $bulantotal : $totalmk',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: seluruhalurdana.length,
                          itemBuilder: (context, index) {
                            CashflowModel alurdana = seluruhalurdana[index];

                            return MyTransaction(
                              alurdana: alurdana,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const Expanded(
                child: Center(
                  child: Text("Tidak ada data"),
                ),
              );
      });
}
