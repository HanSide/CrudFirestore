import 'package:flutter/material.dart';

class FoodListPage extends StatelessWidget {
  const FoodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Makanan"),
        centerTitle: true,
      ),

      // BUTTON ACTION TAMBAH MENU (UI SAJA)
      floatingActionButton: FloatingActionButton(
        onPressed: null, // UI only
        child: const Icon(Icons.add),
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          FoodItemCard(
            name: "Nasi Goreng",
            price: "Rp 15.000",
          ),
          FoodItemCard(
            name: "Mie Ayam",
            price: "Rp 12.000",
          ),
          FoodItemCard(
            name: "Ayam Geprek",
            price: "Rp 18.000",
          ),
          FoodItemCard(
            name: "Bakso",
            price: "Rp 13.000",
          ),
        ],
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final String name;
  final String price;

  const FoodItemCard({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // INFO MAKANAN
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            // ACTION BUTTONS (UI ONLY)
            Row(
              children: [
                // DELETE ICON
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 18,
                  ),
                ),

                // PESAN BUTTON
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "Pesan",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
