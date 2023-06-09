

// import 'package:flutter/material.dart';



// import '../bloc/bloc.dart';
// import '../models/models.dart';

// class ExportButton extends StatefulWidget {
//   final int bulanaktif;
//   final String namasheet;

//   const ExportButton({required this.bulanaktif, required this.namasheet});

//   @override
//   State<ExportButton> createState() => _ExportButtonState();
// }

// class _ExportButtonState extends State<ExportButton> {
//   @override
//   Widget build(BuildContext context) {
//    CashflowBloc alurdanaA = context.watch<CashflowBloc>();

//     return StreamBuilder<List<CashflowModel>>(
//       stream: alurdanaA.streamAlurDana(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//         if (!snapshot.hasData) {
//           return const Expanded(child: Text('Tidak Ada Data'));
//         }
//         if (snapshot.hasError) {
//           return Expanded(child: Text('Error: ${snapshot.error}'));
//         }
//         List<CashflowModel> allAlurdana = [];
//         snapshot.data!.forEach((element) {
//           CashflowModel rawalurdana = element;
//           rawalurdana.id = element.id;
//           allAlurdana.add(rawalurdana);
//         });
//         final seluruhalurdana = allAlurdana
//             .where((d) => d.createdAt.month == widget.bulanaktif + 1)
//             .toList();

//         return BlocConsumer<ExporttogsheetsBloc, ExporttogsheetsState>(
//           listener: (context, state) {
//             if (state is SuccessState) {
//               // Show SnackBar when export is successful
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Export to Google Sheets Berhasil!'),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             return GestureDetector(
//               onTap: () {
//                 final exporttogsheetsBloc = context.read<ExporttogsheetsBloc>();
//                 exporttogsheetsBloc.add(
//                   ExporttogsheetsEventWrite(
//                     widget.namasheet,
//                     seluruhalurdana.reversed.toList(),
//                   ),
//                 );
//               },
//               child: SafeArea(
//                 child: Container(
//                   height: 60,
//                   width: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[400],
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Center(
//                     child: Icon(Icons.file_copy_outlined),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
