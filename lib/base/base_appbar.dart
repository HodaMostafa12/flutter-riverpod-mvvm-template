import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget baseAppBar(context, String tittle) {
  return AppBar(
    title: Text(
      tittle,
      style: const TextStyle(color: Colors.black),
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}
