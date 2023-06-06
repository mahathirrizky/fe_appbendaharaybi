import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../bloc/bloc.dart';
import '../constants/constants.dart';
import '../routes/router.dart';

class DrawerSidebar extends StatelessWidget {
  const DrawerSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: myDefaultBGColor,
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset(
              'assets/images/logoybi.png',
              height: 150,
              width: 150,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('D A S H B O A R D'),
            onTap: () {
              context.goNamed(Routes.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text('E X P O R T'),
            onTap: () {
              context.goNamed(Routes.export);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LO G O U T'),
            onTap: () {
              context.read<AuthBloc>().add(AuthEventLogout());
              context.goNamed(Routes.login);
            },
          ),
        ],
      ),
    );
    ;
  }
}
