
import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
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

        final seluruhalurdana =
            tahun.where((d) => d.createdAt.month == bulanaktif + 1).toList();

        return seluruhalurdana.isNotEmpty
            ? Expanded(
                child: Center(
                  child: Column(
                    children: [
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
