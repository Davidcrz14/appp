import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          child: Text('Iniciar sesión'),
          onPressed: () {
            // Aquí iría tu lógica de autenticación
            Navigator.of(context).pushReplacementNamed('/home');
          },
        ),
      ),
    );
  }
}
