import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString strongPass = "".obs;
  Rx<Color> color = Colors.grey.obs;

  void strongPassCalc(String pass) {
    if (pass.length < 6) {
      strongPass.value = "Senha fraca";
      color.value = Colors.red;
    }
    if (pass.length > 6 && pass.contains(RegExp(r'[A-Za-z]'))) {
      strongPass.value = "Senha média";
      color.value = Colors.yellow;
    }
    if (pass.length > 6 && pass.contains(RegExp(r'[A-Za-z]')) && pass.contains(RegExp(r'[0-9]'))) {
      strongPass.value = "Senha Forte";
      color.value = Colors.green;
    }
    if (pass.isEmpty) {
      strongPass.value = "";
      color.value = Colors.grey;
    }
  }

  void login(String email, String pass) {
    if (email == "teste@teste.com" && pass == "Teste1234") {
      Get.offAndToNamed("/home");
    } else {
      Get.snackbar("Ops!", "Credenciais inválidas!", backgroundColor: Colors.red, snackStyle: SnackStyle.FLOATING, snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(20));
    }
  }
}
