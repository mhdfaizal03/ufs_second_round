import 'package:flutter/material.dart';

 // most used widget

void customSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
