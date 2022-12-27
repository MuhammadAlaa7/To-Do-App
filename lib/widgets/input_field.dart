import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_2/theme.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;

  final Widget? widget;
  final TextEditingController? controller;

  const InputField({
  super.key,
  required this.title,
  required this.hint,
  this.widget,
  this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: subHeadLine,
          ),
          Container(
            margin: const EdgeInsets.only(left: 0 , top: 5,),
            padding: const EdgeInsets.only(top: 5 , left: 5, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget != null ? true : false,
                    cursorColor: Get.isDarkMode ? Colors.grey : Colors.blue,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: titleStyle,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
