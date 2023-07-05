import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:log/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
/*
theme: ThemeData(
  colorScheme: ThemeData().colorScheme.copyWith(
    secondary: Colors.blue,
  ),
),
*/
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Colors.red,
            ),
        textTheme: GoogleFonts.lexendDecaTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
