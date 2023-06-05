import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/constant/string_constants.dart';

class LocalDataSaver {
  static String name = StringConstant.nameLocalDataSaver;
  static String email=StringConstant.emailLocalDataSaver;
  static String password = StringConstant.passwordLocalDataSaver;
  static String confirmPassword=StringConstant.confirmPasswordLocalDataSaver;


//These lines define two static variables name and password, which are used as keys to identify the data stored in the shared preferences.


  static Future<bool> saveName(String names) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(name,names);
  }

  static Future<String?> getSaveName() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(name);
  }
  static Future<bool> saveEmail(String emails) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(email,emails);
  }
  static Future<String?> getSaveEmail() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(email);
  }

  static Future<bool> savePassword(String passwords) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(password,passwords);
  }
  static Future<String?> getSavePassword() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(password);
  }
  static Future<bool> saveConfirmPassword(String confirmPasswords) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(confirmPassword, confirmPasswords);
  }

  static Future<String?> getSaveConfirmPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(confirmPassword);
  }

   static  Future<void> removeAll() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove(name);
      await preferences.remove(password);
      await preferences.remove(email);
      await preferences.remove(confirmPassword);

      //The removeAll method removes the stored name and password from the shared preferences by calling the remove method for each key.
    }
  }

