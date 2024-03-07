import 'package:sqflite/sqflite.dart';
import '../JsonModels/fooddonate.dart';
import '../JsonModels/users.dart';
import 'package:path/path.dart';


class DatabaseFile {

  final databaseName = "donation.db";

  String DonateTable = '''
      CREATE TABLE donate (
      donateID INTEGER PRIMARY KEY AUTOINCREMENT,
      userID INTEGER NOT NULL,
      pickupaddress TEXT NOT NULL, 
      fooditems TEXT NOT NULL, 
      pickupdate DATE NOT NULL,
      pickuptime TEXT NOT NULL, 
      quantity INT NOT NULL, 
      category TEXT NOT NULL,
      )''';

  String UserTable = '''
      CREATE TABLE users (
      userID INTEGER PRIMARY KEY AUTOINCREMENT,
      fullname TEXT NOT NULL, 
      email TEXT UNIQUE,
      phonenumber TEXT NOT NULL, 
      username TEXT UNIQUE, 
      userpassword TEXT NOT NULL)''';


  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(DonateTable);
      await db.execute(UserTable);
    });
  }

  Future<List<Map<String, dynamic>>> getDonationItems() async {
    final databasePath = await initDB();
    return databasePath.query(DonateTable);
  }

  void printTableInfo() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'donation.db'),
    );

    // Perform a SELECT query to retrieve all rows from the "users" table
    List<Map<String, dynamic>> allUserData =
    await database.rawQuery(
        'SELECT * FROM users;');

    // Print the retrieved data
    if (allUserData.isNotEmpty) {
      print('All User Data:');
      for (var userData in allUserData) {
        userData.forEach((key, value) {
          print('$key: $value');
        });
        // Separating each user's data for clarity
        print('--------------------------');
      }
    } else {
      print('No data found in the "users" table.');
    }
  }


  // Login method
  Future<UsersModel?> loginUser(UsersModel user) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "select * from users where username = '${user.username}' "
            "AND userpassword = '${user.password}'");

    printTableInfo();
    if (result.isNotEmpty) {
      UsersModel loggedInUser = UsersModel.fromMap(result.first);
      return loggedInUser;
    } else {
      return null;
    }
  }


  //Sign up
  Future<int> signup(UsersModel user) async {
    final Database db = await initDB();

    // To view the data in the table
    printTableInfo();
    return db.insert('users', user.toMap());
  }

  //Donation form
  Future<int> donateform(FoodDonateModel food) async {
    final Database db = await initDB();

    // To view the data in the table
    printTableInfo();
    return db.insert('donate', food.toMap());
  }


  // Donate history
  Future<bool> donateHistory(FoodDonateModel food) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "select fooditems, pickupdate from donate"
            "where username = '${food.userID}'");

    printTableInfo();
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<FoodDonateModel>> fetchData(int? food) async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> queryResult = await db.query(
      'donate', // Specify the table name
      where: 'userID = ?', // Specify the WHERE clause
      whereArgs: [food], // Specify the values for the WHERE clause
    );
    return queryResult.map((e) => FoodDonateModel.fromMap(e)).toList();
  }
}