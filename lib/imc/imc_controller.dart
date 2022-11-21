import 'package:completo/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class ImcController extends GetxController {
  RxString resultado = "".obs;
  String loggedUser = "";
  var history = [].obs;

  @override
  void onInit() async {
    final sp = await SharedPreferences.getInstance();
    loggedUser = sp.getString("logged_user") ?? "";
    super.onInit();
  }

  Future<List> getImcHistory() async {
    Database db = await DatabaseHelper.setDatabase();
    history.assignAll(await db.rawQuery("SELECT * FROM imc WHERE email = ? ORDER BY id DESC LIMIT 5;", [loggedUser]));
    return history;
  }

  void imcCalc(double altura, double peso) async {
    double result = peso / (altura * altura);

    if (result < 16) {
      resultado.value = 'Magreza grave';
    } else if (result < 17) {
      resultado.value = 'Magreza moderada';
    } else if (result < 18.5) {
      resultado.value = 'Magreza leve';
    } else if (result < 25) {
      resultado.value = 'Saudável';
    } else if (result < 30) {
      resultado.value = 'Sobrepeso';
    } else if (result < 35) {
      resultado.value = 'Obesidade – Grau I';
    } else if (result < 40) {
      resultado.value = 'Obesidade – Grau II (Severa)';
    } else {
      resultado.value = 'Obesidade – Grau III (Mórbida)';
    }
    if (loggedUser != "") await DatabaseHelper.newImc(email: loggedUser, peso: peso, altura: altura, imc: resultado.value);
  }
}
