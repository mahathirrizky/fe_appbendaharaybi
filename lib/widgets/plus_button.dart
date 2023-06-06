import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final function;

  PlusButton({this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: SafeArea(
        child: Container(
          height: 60,
          width: 60,
          decoration:
              BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle),
          child: const Center(
            child: Text(
              '+',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
