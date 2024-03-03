
import 'package:flutter/material.dart';
import 'package:temp_email/responsive/dimension.dart';
import 'package:temp_email/utils/color.dart';
import 'package:temp_email/widget/header_text.dart';

class HeaderSection extends StatelessWidget {
  final String heading;
  const HeaderSection({
    super.key, required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                padding:   EdgeInsets.all(AppDimensions.w5),
                child:  ScreenHeaderText(
                  text: heading,
                )),
            Container(
              width: double.infinity,
              height: AppDimensions.h20,
              decoration:  BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(AppDimensions.h20*2.5))),
            ),
            Container(
              color: Colors.blue,
              child: Container(
                height: AppDimensions.h20*1.5,
                decoration: BoxDecoration(
                    color: AppColors().backgroundColor,
                    borderRadius:
                         BorderRadius.only(topRight: Radius.circular(AppDimensions.h20*2.5))),
                width: double.infinity,
              ),
            ),
          ],
        ));
  }
}
