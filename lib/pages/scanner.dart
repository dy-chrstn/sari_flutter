import 'package:flutter/material.dart';

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Scanner',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
