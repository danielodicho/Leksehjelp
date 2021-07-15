import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String sharedPreferenceUserLoggedInKey = 'ISLOGGEDIN';
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";


  // asså desse verdiane må bli lagra til sharedpreference librarien

  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }


  static Future<bool> saveUserNameInSharedPreference(String userName)
  async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
       return await prefs.setString(sharedPreferenceUserNameKey, userName);
}

  static Future<bool> saveUserEmailInSharedPreference(String userEmail)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  static Future<bool?> getUserLoggedInSharedPreference()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }



  static Future<String?> getUserNameSharedPreference()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String?> getUserEmailSharedPreference()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }


}
