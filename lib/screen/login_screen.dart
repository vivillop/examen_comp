import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:examen_vvl/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: Text(
                    "Bienvenidos",
                    style: TextStyle(
                      fontSize: 50,
                      color: Color.fromARGB(255, 39, 1, 36),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CustomButton(
                text: "Iniciar sesión",
                onPressed: () => Navigator.pushNamed(context, "loginEmail",
                    arguments: {"first": true}),
              ),
              CustomButton(
                text: "Registrate",
                onPressed: () => Navigator.pushNamed(context, "registerEmail",
                    arguments: {"first": true}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
