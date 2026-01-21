import 'package:crud_firestore/controller/food_controller.dart';
import 'package:get/get.dart';

class FoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FoodController());
  }
}
