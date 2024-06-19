import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_demo/src/contacts_screen.dart';
import 'package:prueba_demo/src/home_screen.dart';
import 'package:prueba_demo/src/login_screen.dart';
import 'package:prueba_demo/src/send_money_screen.dart';
//import 'package:prueba_demo/src/settings_screen.dart';
import 'package:prueba_demo/src/app_data.dart'; // Asegúrate de importar AppData

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Definir las rutas de conexión entre el login y el home
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Login',
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/settings': (context) =>
              const SettingsScreen(), // Descomentar si es necesario
          '/send': (context) => const SendMoneyScreen(),
          '/contacts': (context) => const ContactsScreen(),
        },
      ),
    );
  }
}
