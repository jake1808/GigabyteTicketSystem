import 'package:gigabyte_ticket_system/features/registration/data/models/users.dart';
import 'package:sqflite/sqflite.dart';

class DataLinkRegistration {
  static Future<int> registerUser(User user) async {
    late int id;
    try {
      //locate database
      String dataBasePath = await getDatabasesPath();
      String path = dataBasePath + 'TicketSystem.db';
      print(path + ' here');
      //open the database
      Database database = await openDatabase(path);
      //insert records
      await database.transaction((txn) async {
        id = await txn.rawInsert(
            'INSERT INTO Users(Name, Surname, Companyname, Telephone, Email, Address, City, Region, Username, Password) VALUES(${user.name}, ${user.surName}, ${user.companyName}, ${user.telePhoneNumber}, ${user.email}, ${user.address}, ${user.city}, ${user.region}, ${user.userName}, ${user.password})');
        print('INSERTED: $id');
      });
      //close database
      database.close();
      return id;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static Future<bool> checkUserAvailable(String name) async {
    late bool availableUser;
    try {
      //locate database
      String dataBasePath = await getDatabasesPath();
      String path = dataBasePath + 'TicketSystem.db';
      print(path + ' here');
      //open the database
      Database database = await openDatabase(path);
      //search for the instance of the user
      int? count = Sqflite.firstIntValue(await database
          .rawQuery('SELECT COUNT(*) FROM Users WHERE Username == $name'));
      //close database
      database.close();
      return count != null ? availableUser = true : availableUser = false;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
