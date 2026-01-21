import 'package:crud_firestore/controller/food_controller.dart';
import 'package:crud_firestore/pages/food_Mobile.dart';
import 'package:crud_firestore/pages/food_Tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final foodController = Get.put((FoodController()));
          foodController.updateScreenSize(context);
          return Obx(
            () => foodController.isMobile.value
                ? FoodMobilePage()
                : FoodTabletPage(),
          );
        },
      ),
    );
  }
}
