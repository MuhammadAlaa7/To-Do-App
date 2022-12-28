import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_2/db/db_helper.dart';

import '../module/task.dart';
import '../services/theme_service.dart';

class TaskController extends GetxController {
  //final RxList<Task> tasksList = <Task>[].obs;

  TextEditingController? titleController = TextEditingController();

  TextEditingController? noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  changeSelectedDate(DateTime date) {
    selectedDate = date;
    update();
    log('selected data is ${DateFormat.yMd().format(selectedDate)}');
  }

  void changeTheme() {
    ThemeService().switchTheme();
    update();
  }

  void changeDatePickerState(DateTime pickedDate) {
    selectedDate = pickedDate;
    update();
  }

  void changeReminderState(int newDate) {
    selectedReminder = newDate;
    update();
  }

  void changeRepeatState(String newDate) {
    selectedRepeat = newDate;
    update();
  }

  String startTime = DateFormat('hh:mm a').format(DateTime.now());

  var endTime = DateFormat('hh:mm a').format(
    DateTime.now().add(
      const Duration(
        minutes: 20,
      ),
    ),
  );

  int selectedReminder = 5;
  List<int> reminderList = [5, 10, 15, 20, 25, 30];

  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];

  int selectedColor = 0;

  List<Task> tasksList = <Task>[];

  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.getDataFromDB();
    tasksList.assignAll(tasks.map((map) => Task.fromJson(map)));
  }

// Here I'm sending the values of the task
// this method is to insert and get after
  void addTask() async {
    changeSelectedDate(selectedDate);
    print('selected data changed firsst ');
    DBHelper.insertDataIntoDB(
      task: Task(
        title: titleController!.text,
        note: noteController!.text,
        date: DateFormat.yMd().format(selectedDate),
        isCompleted: 0,
        color: selectedColor,
        startTime: startTime,
        endTime: endTime,
        repeat: selectedRepeat,
        remind: selectedReminder,
      ),
    ).then(
      (value) {
        getTasks().then(
          (value) {
            update();
            print('update....');
            print('insertion done ...');
          },
        );
      },
    );
  }

// update the task to make it completed
  void markAsCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
    update();
  }

  void deleteTask(Task task) {
    DBHelper.delete(task).then((value) {
      getTasks();
      update();
    });
  }

  void deleteAll() async {
    await DBHelper.deleteAllDB();
    update();
    getTasks();
  }
}
