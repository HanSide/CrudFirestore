
import 'package:crud_firestore/route/pages.dart';
import 'package:crud_firestore/route/route.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

late FirebaseDatabase database;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
        'https://crudfirestore-80a6b-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MekBudget',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.foodPage,
      getPages: AppPage.pages,
    );
  }
}
