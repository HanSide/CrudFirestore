import 'package:crud_firestore/controller/food_controller.dart';
import 'package:crud_firestore/widget/custom_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodTabletPage extends StatelessWidget {
  const FoodTabletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoodController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Makanan - Tablet"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.showAddDialog,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Menu'),
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
                Icon(Icons.restaurant_menu, size: 120, color: Colors.grey),
                SizedBox(height: 24),
                Text(
                  'Belum ada menu makanan',
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: controller.showAddDialog,
                  icon: Icon(Icons.add),
                  label: Text('Tambah Menu'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
              ],
            ),
          );
        }

       
        return GridView.builder(
          padding: const EdgeInsets.all(24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.gridColumns,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.2,
          ),
          itemCount: controller.foodList.length,
          itemBuilder: (context, index) {
            final food = controller.foodList[index];
            return TabletFoodCard(food: food, controller: controller);
          },
        );
      }),
    );
  }
}