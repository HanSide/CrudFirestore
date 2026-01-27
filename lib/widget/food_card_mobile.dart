import 'package:crud_firestore/controller/food_controller.dart';
import 'package:crud_firestore/model/food_model.dart';
import 'package:flutter/material.dart';

class FoodCardMobile extends StatelessWidget {
  final Makanan food;
  final FoodController controller;

  const FoodCardMobile({
    super.key,
    required this.food,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(food.nama,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text("Rp ${food.harga}",
                      style: const TextStyle(color: Color.fromARGB(255, 36, 163, 253))),
                ],
              ),
            ),

            _iconButton(
              Icons.edit,
              Colors.orange,
              () => controller.showEditDialog(food),
            ),
            _iconButton(
              Icons.delete,
              Colors.red,
              () => controller.showDeleteDialog(food.key!, food.nama),
            ),
            _textButton(
              () => controller.pesanMakanan(food.nama),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration:
              BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255), size: 18),
        ),
      ),
    );
  }

  Widget _textButton(VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ElevatedButton(
        onPressed: onTap,
        child: const Text("Pesan"),
      ),
    );
  }
}
