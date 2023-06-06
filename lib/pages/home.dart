import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../constants/constants.dart';
import '../responsive/responsive_layout.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void _transaksibaru() {
  //   showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(
  //           builder: (BuildContext context, setState) {
  //             return const AlertCashFlow();
  //           },
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
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
                        // streambuildertopcard(alurdanaB),
                        // streambuilderlistdanamasukdankeluar(alurdanaB),
                        const SizedBox(
                          height: 10,
                        ),
                        // PlusButton(
                        //   function: _transaksibaru,
                        // ),
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
                  // streambuildertopcard(alurdanaB),
                  // streambuilderlistdanamasukdankeluar(alurdanaB),
                  const SizedBox(
                    height: 10,
                  ),
                  // PlusButton(
                  //   function: _transaksibaru,
                  // ),
                ],
              ),
            ),
    );
  }
}
