import 'package:get/get.dart';
import './temp_controller.dart';

class TempBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(TempController());
    }
}