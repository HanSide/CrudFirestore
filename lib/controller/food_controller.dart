import 'package:crud_firestore/main.dart';
import 'package:crud_firestore/model/food_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class FoodController extends GetxController {
  final DatabaseReference _dbRef = database.ref().child('makanan');

  var foodList = <Makanan>[].obs;
  var isLoading = false.obs;

  final namaController = TextEditingController();
  final hargaController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchFoods();
  }

  @override
  void onClose() {
    namaController.dispose();
    hargaController.dispose();
    super.onClose();
  }

  var isMobile = true.obs;
  var screenWidth = 0.0.obs;

  void updateScreenSize(BuildContext context) {
    screenWidth.value = MediaQuery.of(context).size.width;
    isMobile.value = screenWidth.value < 600;
  }

  int get gridColumns {
    if (screenWidth.value >= 900) return 3;
    if (screenWidth.value >= 600) return 2;
    return 1;
  }

  void fetchFoods() {
    _dbRef.onValue.listen((event) {
      foodList.clear();

      final data = event.snapshot.value;

      if (data != null && data is Map) {
        data.forEach((key, value) {
          if (value is Map) {
            foodList.add(Makanan.fromMap(key, value));
          }
        });
      }
    });
  }

  Future<void> tambahMakanan() async {
    if (namaController.text.isEmpty || hargaController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Nama dan harga tidak boleh kosong!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final newRef = _dbRef.push();

      final food = Makanan(
        nama: namaController.text,
        harga: hargaController.text,
      );

      await newRef.set(food.toMap());

      namaController.clear();
      hargaController.clear();
      Get.back();

      Get.snackbar(
        'Berhasil',
        'Menu berhasil ditambahkan!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateMakanan(Makanan food) async {
    try {
      isLoading.value = true;

      await _dbRef.child(food.key!).update({
        'nama': namaController.text,
        'harga': hargaController.text,
      });

      namaController.clear();
      hargaController.clear();
      Get.back();

      Get.snackbar(
        'Berhasil',
        'Menu berhasil diupdate!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> hapusMakanan(String key) async {
    try {
      isLoading.value = true;

      await _dbRef.child(key).remove();

      Get.snackbar(
        'Berhasil',
        'Menu berhasil dihapus!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showAddDialog() {
    Get.defaultDialog(
      title: 'Tambah Menu',
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Makanan',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.restaurant),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: hargaController,
              decoration: InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      textConfirm: 'Tambah',
      textCancel: 'Batal',
      confirmTextColor: Colors.white,
      onConfirm: tambahMakanan,
      onCancel: () {
        namaController.clear();
        hargaController.clear();
      },
    );
  }

  void showEditDialog(Makanan food) {
    namaController.text = food.nama;
    hargaController.text = food.harga;

    Get.defaultDialog(
      title: 'Edit Menu',
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Makanan',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: hargaController,
              decoration: InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      textConfirm: 'Update',
      textCancel: 'Batal',
      confirmTextColor: Colors.white,
      onConfirm: () => updateMakanan(food),
      onCancel: () {
        namaController.clear();
        hargaController.clear();
      },
    );
  }

  void showDeleteDialog(String key, String nama) {
    Get.defaultDialog(
      title: 'Konfirmasi Hapus',
      middleText: 'Yakin ingin menghapus "$nama"?',
      textConfirm: 'Hapus',
      textCancel: 'Batal',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        hapusMakanan(key);
        Get.back();
      },
    );
  }

  void pesanMakanan(String nama) {
    Get.snackbar(
      'Pesanan',
      'Anda memesan: $nama',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }
}
