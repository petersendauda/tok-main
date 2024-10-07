import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Make sure this is imported
import 'package:tok/modules/login/login.dart';
import 'package:tok/widget/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDbWxKVO38PDUse5E5E2ICpcnKyiSnIP7E",
      authDomain: "tokproject-7f538.firebaseapp.com",
      projectId: "tokproject-7f538",
      storageBucket: "tokproject-7f538.appspot.com",
      messagingSenderId: "105962563026",
      appId: "1:105962563026:web:5b16e155b223f66446140b",
      measurementId: "G-ZEKRY387S4",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Add other providers here if needed
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: const Login(),
            theme: themeProvider.themeData,
          );
        },
      ),
    );
  }
}