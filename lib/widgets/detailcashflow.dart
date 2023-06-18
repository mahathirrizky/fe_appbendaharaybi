import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DetailCashflow extends StatelessWidget {
  final String namatransaksi;
  final String jumlahuang;
  final String tanggal;
  String? imageURL;
  DetailCashflow(
      {super.key,
      required this.namatransaksi,
      required this.jumlahuang,
      required this.tanggal,
      this.imageURL});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Center(child: Text('D E T A I L  C A S H F L O W')),
      content: SingleChildScrollView(
        child: Column(
          children: [
            if (imageURL != "")
              GestureDetector(
                onLongPress: () {
                  showImageViewer(context, NetworkImage(urlimage + imageURL!),
                      swipeDismissible: false);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(urlimage + imageURL!),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Form(
                    child: Text(namatransaksi),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Form(
                    child: Text(
                      FormatCurrency.convertToIdr(int.parse(jumlahuang), 0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Form(child: Text(tanggal)),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: MaterialButton(
            color: Colors.grey[600],
            child: const Text(
              'KELUAR',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }
}
