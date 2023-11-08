import 'package:flutter/material.dart';
import 'package:projet_d_integration/Screens/home.dart';
import 'package:projet_d_integration/widgets/bottomnavigationbar.dart';

import 'Screens/statistics.dart';

void main() async {
  /*await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');*/
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Bottom(),
    );
  }
}