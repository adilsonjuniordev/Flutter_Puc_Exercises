import 'package:get/get.dart';
import './cadastro_controller.dart';

class CadastroBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(CadastroController());
    }
}