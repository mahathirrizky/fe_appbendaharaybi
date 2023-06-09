import 'package:appbendaharaybi/models/cashflow_model.dart';

import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

StreamBuilder<List<CashflowModel>> streambuilderlistdanamasukdankeluar(
    CashflowBloc cashflowaB) {
  return StreamBuilder<List<CashflowModel>>(
      stream: cashflowaB.streamAlurDana(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
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
        for (var element in snapshot.data!) {
          
          allAlurdana.add(element);
        }
        return Expanded(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: allAlurdana.length,
                    itemBuilder: (context, index) {
                      CashflowModel alurdana = allAlurdana[index];

                      return MyTransaction(
                        alurdana: alurdana,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
