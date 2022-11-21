import 'package:get/get.dart';
import './imc_controller.dart';

class ImcBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(ImcController());
    }
}