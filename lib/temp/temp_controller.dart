import 'package:completo/database/database_helper.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class TempController extends GetxController {
  var tempFinal = 0.0.obs;
  var medidaFinal = "".obs;
  var history = [].obs;
  String loggedUser = "";

  @override
  void onInit() async {
    final sp = await SharedPreferences.getInstance();
    loggedUser = sp.getString("logged_user") ?? "";
    super.onInit();
  }

  Future<List> getTempHistory() async {
    Database db = await DatabaseHelper.setDatabase();
    history.assignAll(await db.rawQuery("SELECT * FROM temp WHERE email = ? ORDER BY id DESC LIMIT 5;", [loggedUser]));
    return history;
  }

  void tempCalc(double temp, String medida) async {
    switch (medida) {
      case "kelvin":
        tempFinal.value = (temp + 273.15).toPrecision(2);
        medidaFinal.value = medida;
        if (loggedUser != "") await DatabaseHelper.newTemp(email: loggedUser, celsius: temp, tipo: medida, valor: tempFinal.value);
        break;
      case "fahrenheit":
        tempFinal.value = ((temp * (9 / 5)) + 32).toPrecision(2);
        medidaFinal.value = medida;
        if (loggedUser != "") await DatabaseHelper.newTemp(email: loggedUser, celsius: temp, tipo: medida, valor: tempFinal.value);
        break;
      case "rankine":
        tempFinal.value = ((temp * (9 / 5)) + 491.67).toPrecision(2);
        medidaFinal.value = medida;
        if (loggedUser != "") await DatabaseHelper.newTemp(email: loggedUser, celsius: temp, tipo: medida, valor: tempFinal.value);
        break;
      case "reaumur":
        tempFinal.value = (temp * (4 / 5)).toPrecision(2);
        medidaFinal.value = medida;
        if (loggedUser != "") await DatabaseHelper.newTemp(email: loggedUser, celsius: temp, tipo: medida, valor: tempFinal.value);
        break;

      default:
    }
  }
}
