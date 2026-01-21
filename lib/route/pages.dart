import 'package:crud_firestore/binding/food_binding.dart';
import 'package:crud_firestore/pages/foodPages.dart';
import 'package:crud_firestore/route/route.dart';
import 'package:get/get.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: AppRoutes.foodPage,
      page: () => FoodPage(),
      binding: FoodBinding(),
    ),
  ];
}
