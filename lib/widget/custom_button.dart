// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:temp_email/responsive/dimension.dart';
import 'package:temp_email/utils/color.dart';

class RoundButton extends StatelessWidget {
  final String text;
  const RoundButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(AppDimensions.h10),
    // margin: EdgeInsets.symmetric(horizontal: 20),
      
     
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.h10),
        color: AppColors().green,
      ),
      alignment: Alignment.center,
      child: Text(
       text,
        style: TextStyle(
            color: Colors.white, fontSize: AppDimensions.font17,fontWeight: FontWeight.bold
            ,
            ),
      ),
    );
  }
}
