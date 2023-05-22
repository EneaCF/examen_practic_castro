import 'package:examen_practic_castro/screens/usuario_screen.dart';
import 'package:examen_practic_castro/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UsuarioService(),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Flutter',
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
        'usuario': (_) => UsuarioScreen(),
        //'nuevo': (_) => NuevoScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
