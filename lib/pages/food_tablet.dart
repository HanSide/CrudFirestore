import 'package:crud_firestore/controller/food_controller.dart';
import 'package:crud_firestore/widget/food_card_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodTabletPage extends StatelessWidget {
  const FoodTabletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoodController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      /// APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFFDA291C),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "McMenu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),

      /// FAB
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFFFC72C),
        foregroundColor: Colors.black,
        onPressed: controller.showAddDialog,
        icon: const Icon(Icons.add),
        label: const Text(
          'Tambah Menu',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value && controller.foodList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFDA291C),
            ),
          );
        }

        if (controller.foodList.isEmpty) {
          return _emptyState(controller);
        }

        /// GRID MENU (Tablet)
        return GridView.builder(
          padding: const EdgeInsets.all(24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: controller.gridColumns,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.1,
          ),
          itemCount: controller.foodList.length,
          itemBuilder: (context, index) {
            final food = controller.foodList[index];
            return FoodCardTablet(
              food: food,
              controller: controller,
            );
          },
        );
      }),
    );
  }

  /// EMPTY STATE (SAMA DENGAN MOBILE)
  Widget _emptyState(FoodController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                ),
              ],
            ),
            child: const Icon(
              Icons.fastfood,
              size: 80,
              color: Color(0xFFDA291C),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Menu belum tersedia",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tambahkan menu favoritmu 🍔🍟",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC72C),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
                vertical: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: controller.showAddDialog,
            icon: const Icon(Icons.add),
            label: const Text(
              "Tambah Menu",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
