import 'package:flutter/material.dart';
import 'package:temp_email/responsive/dimension.dart';

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
 
      style:  TextStyle(color: Colors.white, fontSize: AppDimensions.font17),
    );
  }
}
