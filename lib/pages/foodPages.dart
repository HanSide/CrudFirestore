import 'package:crud_firestore/controller/food_controller.dart';
import 'package:crud_firestore/widget/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FoodController());

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Makanan"), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        onPressed: controller.showAddDialog,
        child: const Icon(Icons.add),
      ),

      body: Obx(() {

        if (controller.isLoading.value && controller.foodList.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.foodList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant_menu, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Belum ada menu makanan',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: controller.showAddDialog,
                  icon: Icon(Icons.add),
                  label: Text('Tambah Menu'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.foodList.length,
          itemBuilder: (context, index) {
            final food = controller.foodList[index];
            return FoodItemCard(food: food, controller: controller);
          },
        );
      }),
    );
  }
}
