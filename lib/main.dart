import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_2/db/db_helper.dart';
import 'package:todo_2/services/theme_service.dart';
import 'package:todo_2/theme.dart';
import 'controller/controller.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper.initDB(); // creating the database

  // await DBHelper.deleteDB();
  Get.put(TaskController());
  TaskController controller = Get.find();
  await controller.getTasks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get.put(TaskController());
    //return SimpleBuilder(builder: (_) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: HomeScreen(),
    );
    //  });
  }
}
// If you ever faced any issue or any bad thing DO NOT give up an give
// it a chance and search for it you will find the answer for sure 
/*
(1) - if you are building the app on the phone and it gave you the error >> no such a table in the database\
 >> do this in the terminal >>>> flutter clean and >>>> aflutter pub get 

*/ 