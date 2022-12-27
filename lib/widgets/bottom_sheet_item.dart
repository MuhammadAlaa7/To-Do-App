// Item of bottom sheet
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

Widget bottomSheetItem({
  required String describe,
  required String label,
  required Function() onTap,
  bool isClose = false,
  required BuildContext context,
}) {
  return GestureDetector(
    /// << must do this to make it like a button
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: isClose
        //       ? Get.isDarkMode
        //           ? Colors.grey[600]!
        //           : Colors.grey[300]!
        //       : primaryClr,
        //   width: 2,
        // ),
        color: describe == 'complete'
            ? primaryClr
            : describe == 'delete'
                ? Colors.red
                : white,
      ),
      child: Text(
        label,
        style: Get.isDarkMode
            ? titleStyle
            : titleStyle.copyWith(
                color: Colors.white,
              ),
      ),
    ),
  );
}
