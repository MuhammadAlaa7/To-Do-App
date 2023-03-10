import 'dart:developer';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_2/controller/controller.dart';
import 'package:todo_2/screens/task_screen.dart';
import 'package:todo_2/theme.dart';
import 'package:todo_2/widgets/custom_button.dart';
import 'package:todo_2/widgets/task_tile.dart';

import '../db/db_helper.dart';
import '../module/task.dart';
import '../widgets/bottom_sheet_item.dart';

class HomeScreen extends StatelessWidget {
  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GetBuilder<TaskController>(
          builder: (c) => IconButton(
            onPressed: () {
              controller.changeTheme();
            },
            icon: Icon(
              Get.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny_rounded,
            ),
          ),
        ),
        actions: [
          GetBuilder<TaskController>(
            builder: (x) => IconButton(
              onPressed: () async {
                controller.deleteAll();
              },
              icon: Icon(
                Icons.delete_forever_rounded,
                size: 30,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/person.jpeg'),
            radius: 24,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 10),
        child: Column(
          children: [
            addTaskBar(),
            const SizedBox(
              height: 6.0,
            ),
            dateBar(),
            SizedBox(
              height: 50,
            ),
            showTasks(),
          ],
        ),
      ),
    );
  }

  addTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            DateFormat.yMMMMd().format(DateTime.now()),
            style: subHeadLine,
          ),
          Text(
            'Today',
            style: headline,
          ),
        ]),
        MyButton(
          text: '+Add Task',
          onTap: () async {
            Get.to(TaskScreen());
          },
        ),
      ],
    );
  }

  dateBar() {
    return GetBuilder<TaskController>(
      builder: (c) => DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 60,
        height: 100,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 26,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        selectionColor: primaryClr,
        deactivatedColor: Colors.grey,
        selectedTextColor: Colors.white,
        onDateChange: (date) {
          controller.changeSelectedDate(date);
        },
      ),
    );
  }

  showTasks() {
    return GetBuilder<TaskController>(
      builder: (c) => Expanded(
        child: controller.tasksList.isNotEmpty
            ? ListView.builder(
                itemBuilder: (ctx, int index) {
                  Task task = controller.tasksList[index];

                  if (task.repeat == 'Daily' ||
                      task.date ==
                          DateFormat.yMd().format(controller.selectedDate) ||
                      (task.repeat == 'Weekly' &&
                          controller.selectedDate
                                      .difference(
                                          DateFormat.yMd().parse(task.date!))
                                      .inDays %
                                  7 ==
                              0) ||
                      (task.repeat == 'Monthly' &&
                          controller.selectedDate.day ==
                              DateFormat.yMd().parse(task.date!).day)) {
                    // here : weekly means that the difference between the selected date and the accual date of the task must be 7 days
                    // here : Monthly means that that day in the selected date must equals to the day of the task tade => the same day of each month
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 700),
                      child: SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              showBottomSheet(ctx, task);
                            },
                            child: TaskTile(
                              task,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
                itemCount: controller.tasksList.length,
              )
            : noTasks(),
      ),
    );
  }

  Widget noTasks() {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/task.svg',
          color: primaryClr.withOpacity(0.7),
          height: 250,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'You don\'t have any tasks yet\n Add some tasks to make your day productive',
          textAlign: TextAlign.center,
          style: titleStyle,
        ),
      ],
    );
  }

  void showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        width: MediaQuery.of(context).size.width,
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.35
            : MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? darkHeaderClr : white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 4,
              ),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 6,
              decoration: BoxDecoration(
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            task.isCompleted == 1
                ? Container()
                : bottomSheetItem(
                    color: primaryClr,
                    isClose: false,
                    //  describe: 'complete',
                    context: context,
                    label: 'Complete Task',
                    onTap: () {
                      controller.markAsCompleted(task.id!);
                      Get.back();
                    }),
            bottomSheetItem(
                isClose: false,
                color: Colors.red[300]!,
                context: context,
                label: 'Delete Task',
                onTap: () {
                  controller.deleteTask(task);
                  Get.back();
                }),
            const SizedBox(
              height: 30,
            ),
            bottomSheetItem(
                isClose: true,
                context: context,
                label: 'Cancel',
                onTap: () {
                  Get.back();
                }),
          ],
        ),
      ),
    );
  }
}
