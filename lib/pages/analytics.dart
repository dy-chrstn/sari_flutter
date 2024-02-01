import 'package:flutter/material.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Analytics',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
