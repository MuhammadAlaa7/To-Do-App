import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../controller/controller.dart';
import '../module/task.dart';

class DBHelper {
  static TaskController controller = Get.find();
  static Database? database;
  static String tableName = 'tasks';

  static Future<void> initDB() async {
    if (database != null) {
      print('The data base is not null ');
      return;
    } else {
      // this is the name of the database file
      String path = await getDatabasesPath() + 'tasks.db';
// version 1 >>>> this is the first version because we are creating it it is the first step
      database = await openDatabase(path, version: 1,
          onCreate: (Database database, int version) async {
        print('Database created........');

        database.execute('''
            CREATE TABLE $tableName
            (
              id integer primary key autoincrement,
              title TEXT ,
              note TEXT ,
              date TEXT ,
              startTime TEXT ,
              endTime TEXT ,
              repeat TEXT ,
              isCompleted INTEGER,
              color INTEGER ,
              remind INTEGER 
              )
            ''').then((value) => print('table created......'));
        // remember >> don't put comma after the last column in the sql and before the " ) "
      }, onOpen: (db) {
        //getDataFromDB();
        print('Database opened');
      });
    }
  }

  static Future<void> insertDataIntoDB({required Task task}) async {
    database!.insert(tableName, task.toJson()).then((value) async {
      print('$value has been inserted successfully');
    });

    //todo: focus here >>> the get is outside the insert and inside the whole method
    await getDataFromDB();
  }

  static Future<List<Map<String, dynamic>>> getDataFromDB() async {
    return await database!.query(tableName);
  }

//Delete the whole database
  static Future<void> deleteDB() async {
    String path = await getDatabasesPath() + 'tasks.db';
    await deleteDatabase(path);
    print('delted');
  }

//

  static Future<int> delete(Task task) async {
    return await database!
        .delete(tableName, where: 'id = ?', whereArgs: [task.id]);

    // delete  only the task that its id matches with the id given to you
  }

  static Future<int> update(int id) async {
    // print('data base has been updated');
    return await database!.rawUpdate('''
    UPDATE $tableName 
    SET isCompleted = ? 
    WHERE id = ?
  
    ''', [1, id]

        // set the isCompleted to 1 only if the id is matching with id given
        // هوا هنا بيربط القيم اللي في الاقواس ب علامة الاستفهام
        );
  }
}
