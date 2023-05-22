import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para iniciar sesión
                Navigator.pushNamed(context, "home");
              },
              child: Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
