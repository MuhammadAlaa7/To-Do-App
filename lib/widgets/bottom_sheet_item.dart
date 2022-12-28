// Item of bottom sheet
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

Widget bottomSheetItem({
  //required String describe,
  required String label,
  required Function() onTap,
  Color? color,
  bool isClose = false,
  required BuildContext context,
}) {
  return GestureDetector(
    /// << must do this to make it like a button
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: isClose ? Colors.grey : Colors.transparent,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(40),
        color: isClose ? Colors.transparent : color,
      ),
      child: Text(
        label,
        style: isClose
            ? titleStyle
            : titleStyle.copyWith(
                color: white,
              ),
        // style: Get.isDarkMode
        //     ? titleStyle
        //     : titleStyle.copyWith(
        //         color: Colors.blueGrey,
        //       ),
      ),
    ),
  );
}
