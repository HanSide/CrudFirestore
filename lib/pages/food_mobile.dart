import 'package:crud_firestore/controller/food_controller.dart';
import 'package:crud_firestore/widget/food_card_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodMobilePage extends StatelessWidget {
  const FoodMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FoodController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        backgroundColor: const Color(0xFFDA291C), // merah McD
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "McMenu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFFC72C), // kuning McD
        onPressed: controller.showAddDialog,
        child: const Icon(Icons.add, color: Colors.black),
      ),

      body: Obx(() {
        if (controller.isLoading.value && controller.foodList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFDA291C)),
          );
        }

        if (controller.foodList.isEmpty) {
          return _buildEmptyState(controller);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.foodList.length,
          itemBuilder: (context, index) {
            final food = controller.foodList[index];
            return FoodCardMobile(
              food: food,
              controller: controller,
            );
          },
        );
      }),
    );
  }

  Widget _buildEmptyState(FoodController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Icon(
              Icons.fastfood,
              size: 60,
              color: Color(0xFFDA291C),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Menu belum tersedia",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tambahkan menu favoritmu 🍔🍟",
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC72C),
              foregroundColor: Colors.black,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: controller.showAddDialog,
            icon: const Icon(Icons.add),
            label: const Text("Tambah Menu"),
          ),
        ],
      ),
    );
  }
}
