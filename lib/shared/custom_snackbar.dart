import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Center(
        child: Text(message),
      ),
    ),
  );
}

showErrorSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Center(
        child: Text(message),
      ),
    ),
  );
}
