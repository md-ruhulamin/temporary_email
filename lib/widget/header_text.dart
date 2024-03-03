import 'package:flutter/material.dart';

class ScreenHeaderText extends StatelessWidget {
  final String text;
  const ScreenHeaderText({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return  Text(
     text,
      textAlign: TextAlign.right,
 
      style: const TextStyle(color: Colors.white, fontSize: 18),
    );
  }
}
