import 'package:flutter/material.dart';

class LoadingApp extends StatelessWidget {
  const LoadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
        child: const Center(
            child: CircularProgressIndicator(
          color: Color(0xFF325A3E),
        )));
  }
}
