import 'package:completo/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  RxBool keepConnected = false.obs;

  Future<bool> login({required email, required senha}) async {
    List result = await DatabaseHelper.login(email: email, senha: senha);
    if (result.isEmpty) return false;
    final sp = await SharedPreferences.getInstance();
    await sp.setString("logged_user", email);
    return true;
  }
}
