import 'package:flutter/material.dart';
import '../constants/colorConst.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      backgroundColor: Pallete.white,
      content: Text(
        content,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Pallete.black),
      ),
    ));
}
