// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:temp_email/utils/color.dart';

class RoundButton extends StatelessWidget {
  final String text;
  const RoundButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.all(10),
    // margin: EdgeInsets.symmetric(horizontal: 20),
      
     
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors().green,
      ),
      alignment: Alignment.center,
      child: Text(
       text,
        style: TextStyle(
            color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold
            ,
            ),
      ),
    );
  }
}
