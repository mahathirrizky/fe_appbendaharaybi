
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/bloc.dart';
import '../routes/router.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLogin) {
              context.goNamed(Routes.home);
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          builder: (context, state) {
            return Center(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Text(
                    state is AuthLoading ? 'LOADING...' : "MASUK",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
