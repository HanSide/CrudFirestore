import 'package:crud_firestore/controller/food_controller.dart';
import 'package:crud_firestore/model/food_model.dart';
import 'package:flutter/material.dart';

class FoodCardTablet extends StatelessWidget {
  final Makanan food;
  final FoodController controller;

  const FoodCardTablet({
    super.key,
    required this.food,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  food.nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Rp ${food.harga}",
                  style: const TextStyle(
                      color: Color(0xFFDA291C),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _btn(Icons.edit, Colors.orange,
                    () => controller.showEditDialog(food)),
                _btn(Icons.delete, Colors.red,
                    () => controller.showDeleteDialog(food.key!, food.nama)),
                _btn(Icons.shopping_cart, const Color.fromARGB(255, 9, 140, 248),
                    () => controller.pesanMakanan(food.nama)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _btn(IconData icon, Color color, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      color: color,
    );
  }
}
