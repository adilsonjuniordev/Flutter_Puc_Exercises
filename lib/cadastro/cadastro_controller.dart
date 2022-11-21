import 'package:completo/database/database_helper.dart';
import 'package:get/get.dart';

class CadastroController extends GetxController {
  RxBool showPassword = false.obs;

  Future<bool> cadastro({required nome, required email, required senha}) async {
    int result = await DatabaseHelper.cadastro(nome: nome, email: email, senha: senha);
    if (result == 0) return false;
    return true;
  }
}
