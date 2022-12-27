import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_2/controller/controller.dart';

class ThemeService {
  final TaskController controller = Get.find();

  GetStorage box = GetStorage();
  final key = 'isDark';

  void saveToBox(bool isDark) {
    box.write(key, isDark);
  }

  bool loadFromBox() {
    return box.read<bool>(key) ?? false;
  }

  void switchTheme() {
    Get.changeThemeMode(loadFromBox() ? ThemeMode.dark : ThemeMode.light);
    saveToBox(!loadFromBox());
    // return the opposite of loadFromBox value < true or false>

    print('theme changed');
  }

  ThemeMode get theme => loadFromBox() ? ThemeMode.light : ThemeMode.dark;
}
