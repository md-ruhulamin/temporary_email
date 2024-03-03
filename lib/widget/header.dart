
import 'package:flutter/material.dart';
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
                padding:  const EdgeInsets.all(5),
                child:  ScreenHeaderText(
                  text: heading,
                )),
            Container(
              width: double.infinity,
              height: 20,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(50))),
            ),
            Container(
              color: Colors.blue,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    color: AppColors().backgroundColor,
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(50))),
                width: double.infinity,
              ),
            ),
          ],
        ));
  }
}
