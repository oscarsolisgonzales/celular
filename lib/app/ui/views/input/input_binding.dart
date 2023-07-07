import 'package:appsivalmattel/app/ui/views/input/input_controller.dart';
import 'package:get/get.dart';

class InputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputController());
  }
}
