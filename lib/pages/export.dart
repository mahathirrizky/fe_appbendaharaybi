import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc.dart';
import '../constants/constants.dart';
import '../responsive/responsive_layout.dart';
import '../widgets/widgets.dart';

class ExportPage extends StatefulWidget {
  const ExportPage({super.key});

  @override
  State<ExportPage> createState() => _ExportPageState();
}

class _ExportPageState extends State<ExportPage> {
  int bulanaktif = DateTime.now().month - 1;
  String namasheet = DateFormat('MMM-yyyy').format(DateTime.now());
  int tahunaktif = DateTime.now().year;
  int daftartahun = DateTime.now().year - 9;
  List<int> years = [];

  @override
  Widget build(BuildContext context) {
    while (daftartahun <= tahunaktif) {
      years.add(daftartahun);
      daftartahun++;
    }
    years.sort((a, b) => b.compareTo(a));

    CashflowBloc alurdanaB = context.read<CashflowBloc>();
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: myDefaultBGColor,
      drawer:
          !ResponsiveLayout.isDesktop(context) ? const DrawerSidebar() : null,
      body: ResponsiveLayout.isDesktop(context)
          ? Row(
              children: [
                const DrawerSidebar(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.0,
                          child: GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder:
                                          (BuildContext context, setState) {
                                        return AlertTahun(
                                            tahun: years,
                                            tahunaktif: tahunaktif,
                                            onTahunSelected: (selectedTahun) {
                                              setState(() {
                                                tahunaktif = selectedTahun;
                                              });
                                            });
                                      },
                                    );
                                  },
                                ).then((selectedValue) {
                                  if (selectedValue != null) {
                                    setState(() {
                                      tahunaktif = selectedValue;
                                    });
                                  }
                                });
                              },
                              child: Text(
                                tahunaktif.toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ),
                        AspectRatio(
                          aspectRatio: 10,
                          child: SizedBox(
                            width: double.infinity,
                            child: GridView.builder(
                              itemCount: 12,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 12),
                              itemBuilder: (context, index) {
                                return boxbulan(index);
                              },
                            ),
                          ),
                        ),
                        // streambuilderexport(alurdanaB, bulanaktif, tahunaktif),
                        // const SizedBox(
                        //   height: 10,
                        // ),
                        // ExportButton(
                        //     bulanaktif: bulanaktif, namasheet: namasheet),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50.0,
                    child: GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) {
                                  return AlertTahun(
                                      tahun: years,
                                      tahunaktif: tahunaktif,
                                      onTahunSelected: (selectedTahun) {
                                        setState(() {
                                          tahunaktif = selectedTahun;
                                        });
                                      });
                                },
                              );
                            },
                          ).then((selectedValue) {
                            if (selectedValue != null) {
                              setState(() {
                                tahunaktif = selectedValue;
                              });
                            }
                          });
                        },
                        child: Text(
                          tahunaktif.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                  ),
                  AspectRatio(
                    aspectRatio: ResponsiveLayout.isMobile(context) ? 2.5 : 10,
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: bulan.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                ResponsiveLayout.isMobile(context) ? 6 : 12),
                        itemBuilder: (context, index) {
                          return boxbulan(index);
                        },
                      ),
                    ),
                  ),
                  // streambuilderexport(alurdanaB, bulanaktif, tahunaktif),
                  const SizedBox(
                    height: 10,
                  ),
                  // ExportButton(bulanaktif: bulanaktif, namasheet: namasheet),
                ],
              ),
            ),
    );
  }

  Padding boxbulan(int index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          // bulanaktif = widget.indexbulan;

          setState(() {
            bulanaktif = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: bulanaktif == index ? Colors.grey[500] : Colors.grey[400],
          ),
          child: Center(
            child: Text(
              bulan[index]['label'],
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: bulanaktif == index
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
