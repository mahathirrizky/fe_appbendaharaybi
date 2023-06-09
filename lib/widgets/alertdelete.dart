import 'package:flutter/material.dart';

class AlertDelete extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  AlertDelete({required this.message, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Center(child: Text('W A R N I N G')),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
