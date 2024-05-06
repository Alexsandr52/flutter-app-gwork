// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CastomBox extends StatelessWidget {
  final Widget child;

  CastomBox({required this.child});

  static const Color boxesColor = Color(0xffffffff);
  static const Color constBackgroundColor = Color(0xffe2ecec);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: boxesColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 4.0),
            blurRadius: 6.0,
          ),
        ]
      ),

      child: child,
    );
  }
}
