import 'package:sharecareproject2/JsonModels/users.dart';
import '../sqflite-database/sqflite.dart';

class AuthManager {
  static UsersModel? _currentUser;
  static UsersModel? get currentUser => _currentUser;
  static Future<bool> login(UsersModel user) async {
    final DatabaseFile db = DatabaseFile();
    UsersModel? loggedInUser = await db.loginUser(user);
    if (loggedInUser != null) {
      _currentUser = loggedInUser;
      return true; // Login successful
    } else {
      return false; // Login failed
    }
  }

  static void logout() {
    _currentUser = null;
  }

  static bool isAuthenticated() {
    return _currentUser != null;
  }

}


