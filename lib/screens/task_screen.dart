import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_2/theme.dart';
import 'package:todo_2/widgets/custom_button.dart';
import 'package:todo_2/widgets/input_field.dart';
import '../controller/controller.dart';
import '../widgets/input_field.dart';

class TaskScreen extends StatelessWidget {
  final TaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          CircleAvatar(
            radius: 23,
            backgroundImage: AssetImage(
              'assets/images/person.jpeg',
              // fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: GetBuilder<TaskController>(
            builder: (c) => Column(
              children: [
                Text(
                  'Add Task',
                  style: headline,
                ),
                InputField(
                  title: 'Title',
                  hint: 'Enter Task Title',
                  controller: controller.titleController,
                ),
                InputField(
                  title: 'Note',
                  hint: 'Enter Task Note',
                  controller: controller.noteController,
                ),
                InputField(
                  title: 'Date',
                  hint: DateFormat.yMd().format(controller.selectedDate),
                  widget: IconButton(
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                    onPressed: () => getDateFromUser(context: context),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        title: 'Start Time',
                        hint: controller.startTime,
                        widget: IconButton(
                            icon: Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              getTimeFromUser(isStart: true, context: context);
                            }),
                      ),
                    ),
                    Expanded(
                      child: InputField(
                        title: 'End Time',
                        hint: controller.endTime,
                        widget: IconButton(
                          icon: Icon(
                            Icons.watch_later_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            getTimeFromUser(isStart: false, context: context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                InputField(
                  title: 'Reminder',
                  hint: '${controller.selectedReminder} minutes earlier',
                  widget: DropdownButton<int>(
                    value: controller.selectedReminder,
                    items: controller.reminderList
                        .map(
                          (item) => DropdownMenuItem(
                            child: Text(item.toString()),

                            value: item,

                            /// the item is the numbers of the reminder list
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      controller.changeReminderState(newValue!);
                    },

                    // style of the drop button
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),

                    dropdownColor: Colors.blueGrey,
                    style: TextStyle(
                      color: Get.isDarkMode ? darkHeaderClr : Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    underline: Container(
                      width: 0,
                      height: 0,
                    ),
                  ),
                ),
                InputField(
                  title: 'Repeat',
                  hint: controller.selectedRepeat,
                  widget: DropdownButton(
                    value: controller.selectedRepeat,
                    items: controller.repeatList
                        .map(
                          (item) => DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          ),
                        )
                        .toList(),
                    onChanged: (newValue) {
                      // convert the newValue from object to string first
                      controller.changeRepeatState(newValue.toString());
                    },
                    underline: Container(
                      width: 0,
                      height: 0,
                    ),
                    style: TextStyle(
                      color: Get.isDarkMode ? darkHeaderClr : Colors.white,
                    ),
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 30,
                    ),
                    elevation: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Color',
                            style: subHeadLine,
                          ),
                          Row(
                            children: List.generate(
                              3,
                              (index) => InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  controller.selectedColor = index;
                                  controller.update();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: CircleAvatar(
                                    maxRadius: 15,
                                    child: controller.selectedColor == index
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : null,
                                    backgroundColor: index == 0
                                        ? primaryClr
                                        : index == 1
                                            ? orangeClr
                                            : pinkClr,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      MyButton(
                          text: 'Add Task',
                          onTap: () {
                            validateData();
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateData() {
    if (controller.titleController!.text.isNotEmpty &&
        controller.noteController!.text.isNotEmpty) {
      controller.addTask();
      Get.back();
    } else {
      Get.snackbar(
        'required',
        'All fields must be completed',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.orange,
        backgroundColor: Colors.white,
        icon: Icon(
          Icons.warning_amber_outlined,
          color: Colors.red,
        ),
      );
    }
  }

  getDateFromUser({
    required BuildContext context,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      controller.changeDatePickerState(pickedDate);
    }
  }

  getTimeFromUser({
    required bool isStart,
    required BuildContext context,
  }) async {
    TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: isStart
            ? TimeOfDay.fromDateTime(DateTime.now())
            : TimeOfDay.fromDateTime(
                DateTime.now().add(
                  Duration(minutes: 15),
                ),
              ));

    String formattedTime = pickedTime!.format(context);
    // convert your time into string first because startTime and endTime are string
    // this if you want to convert anything into string >>> use format(context)
    if (isStart == true) {
      controller.startTime = formattedTime;
      controller.update();
    } else {
      controller.endTime = formattedTime;
      controller.update();
    }
  }
}
