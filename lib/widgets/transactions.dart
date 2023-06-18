import 'package:appbendaharaybi/models/cashflow_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';

import '../bloc/bloc.dart';
import '../responsive/responsive_layout.dart';
import 'alertdelete.dart';
import 'alerteditcashflow.dart';
import 'detailcashflow.dart';

class MyTransaction extends StatefulWidget {
  final CashflowModel alurdana;

  MyTransaction({required this.alurdana});

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  _detailalurdana(String namatransaksi, String jumlahuang, String tanggal,
      String? imageURL) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return DetailCashflow(
                namatransaksi: namatransaksi,
                jumlahuang: jumlahuang,
                tanggal: tanggal,
                imageURL: imageURL,
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String tanggal =
        DateFormat('dd-MMM-yyyy').format(widget.alurdana.createdAt);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Dismissible(
        key: Key(widget.alurdana.id.toString()),
        direction: DismissDirection.horizontal,
        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            context.read<CashflowBloc>().add(CashflowEventDelete(
                id: widget.alurdana.id, imageUrl: widget.alurdana.imageurl));
          } else if (direction == DismissDirection.endToStart) {}
        },
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDelete(
                  message: 'Yakin Ingin Menghapus?',
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                );
              },
            );
          } else if (direction == DismissDirection.endToStart) {
            // Show edit dialog here
            return showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return AlertEditDana(alurdana: widget.alurdana);
                  },
                );
              },
            );
          }
        },
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(15),
            color: Colors.grey[100],
            child: GestureDetector(
              onLongPress: () {
                _detailalurdana(
                  widget.alurdana.keterangan,
                  widget.alurdana.jumlah.toString(),
                  tanggal,
                  widget.alurdana.imageurl,
                );
                print(widget.alurdana.imageurl);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey[500]),
                        child: const Center(
                          child: Icon(
                            Icons.attach_money_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (ResponsiveLayout.isMobile(context))
                              SizedBox(
                                width: 150,
                                child: Text(
                                  widget.alurdana.keterangan.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if (!ResponsiveLayout.isMobile(context))
                              SizedBox(
                                child: Text(
                                  widget.alurdana.keterangan.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            Text(
                              tanggal,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${widget.alurdana.jenis == 'danamasuk' ? '+' : '-'}${FormatCurrency.convertToIdr(widget.alurdana.jumlah, 0)}',
                    style: TextStyle(
                        color: (widget.alurdana.jenis == 'danamasuk'
                            ? Colors.green
                            : Colors.red)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
