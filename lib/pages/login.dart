import 'package:flutter/material.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

// import '../bloc/bloc.dart';

// import 'components/my_button.dart';
// import 'components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key});

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Icon(Icons.heart_broken),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "APP CASHFLOW",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: emailC,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: passC,
                  hintText: 'Password',
                  obscureText: true,
                  onSubmitted: (_) {
                    // call the login function when the user presses enter
                    _login(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  onTap: () {
                    _login(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventLogin(emailC.text, passC.text));
  }
}
