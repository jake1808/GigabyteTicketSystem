import 'dart:async';
import 'package:gigabyte_ticket_system/data/models/models.dart';
import 'package:gigabyte_ticket_system/data/models/task.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

var logger = Logger(printer: PrettyPrinter());

class DBhelper {
  DBhelper._();
  static final db = DBhelper._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    logger.w('opening db');
    return await openDatabase(join(await getDatabasesPath(), 'ticketsystem.db'),
        onCreate: (db, version) async {
          await db.execute('''
     CREATE TABLE Users (
    id          INTEGER PRIMARY KEY AUTOINCREMENT ,
    name        STRING ,
    surname     STRING ,
    companyname STRING ,
    telephone   STRING ,
    email       VARCHAR
                        REFERENCES Tickets (Email) MATCH [FULL],
    address     VARCHAR,
    city        STRING ,
    region      STRING ,
    username    VARCHAR,
    password    VARCHAR
)
      ''');
          await db.execute('''
      CREATE TABLE Tickets (
    id                 INTEGER PRIMARY KEY AUTOINCREMENT,
    Urgencylevel             VARCHAR,
    Email                    VARCHAR REFERENCES Users (Email) MATCH [FULL],
    Telephone                STRING ,
    Request                  VARCHAR,
    TicketProblemDescription TEXT,
    Companyname              VARCHAR,
    Branchnamecity           VARCHAR,
    Region                   VARCHAR,
    CompanyAddress           VARCHAR,
    File                     BLOB,
    Name                     VARCHAR,
    Surname                  VARCHAR,
    
)
      ''');
        },
        version: 2,
        onUpgrade: (db, oldVersion, newVersion) async {
          var batch = db.batch();
          if (oldVersion == 1) {
            _upGrade(batch);
            await batch.commit();
          }
        });
  }

  void _upGrade(Batch batch) {
    batch.execute('''
          ALTER TABLE Tickets ADD Status VARCHAR
          ''');
  }

  Future<int> newUser(User user) async {
    final db = await database;

    var res = await db!.rawInsert(
      '''
    INSERT INTO Users(
      name, surname, companyname, telephone, email, address, city, region, username, password
    )VALUES(?,?,?,?,?,?,?,?,?,?)
    ''',
      [
        user.name,
        user.surname,
        user.companyname,
        user.telephone,
        user.email,
        user.address,
        user.city,
        user.region,
        user.username,
        user.password
      ],
    );
    logger.w(res);
    return res;
  }

  Future<User?> getUser(User user) async {
    final db = await database;

    var res = await db!.rawQuery(''' 
    
      SELECT * FROM Users
    
    ''');
    logger.w(res);
    if (res.length == 0) {
      return null;
    } else {
      for (var i = 0; i < res.length; i++) {
        User temp = User.fromMap(res[i]);
        logger.w(temp);
        if (temp.email == user.email && temp.password == user.password) {
          User res = temp;
          return res;
        } else {
          return null;
        }
      }
    }
  }

  Future<List<Map<String, dynamic>>> getTasksMapList() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query("Tickets");
    return result;
  }

  Future<List<Task>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTasksMapList();
    List<Task> taskList = [];
    taskMapList.forEach((element) {
      taskList.add(Task.fromMap(element));
    });
    return taskList;
  }

  Future<int> insertTask(Task task) async {
    final db = await database;
    final int result = await db!.insert('Tickets', task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    final int result = await db!.update(
      'Tickets',
      task.toMap(),
      where: 'id =?',
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int?> deleteTask(int? id) async {
    final db = await database;
    final int result = await db!.delete(
      'Tickets',
      where: 'id =?',
      whereArgs: [id],
    );
    return result;
  }
}
