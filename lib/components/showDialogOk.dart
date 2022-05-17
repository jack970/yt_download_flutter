import 'package:flutter/material.dart';

showAlertDialogOk(title, descricao, context) async {
  await Future.delayed(const Duration(microseconds: 50), );
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(descricao),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}