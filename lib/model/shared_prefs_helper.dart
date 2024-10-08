import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _userIdKey = 'customer_id';
  static const String _keyUserName = 'customer_name';
  static const String _keyUserNum = 'mobile_num';

  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserNum);
  }

  Future<void> saveUserData(
      String customerId, String customerName, String mobileNum) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('customerId', customerId);
    await prefs.setString('customerName', customerName);
    await prefs.setString('mobileNum', mobileNum);
  }

  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final customerId = prefs.getString('customerId') ?? '';
    final customerName = prefs.getString('customerName') ?? '';
    final mobileNum = prefs.getString('mobileNum') ?? '';

    return {
      'customerId': customerId,
      'customerName': customerName,
      'mobileNum': mobileNum,
    };
  }
}
