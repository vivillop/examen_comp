import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/widgets.dart';

class RegisterEmailScreen extends StatelessWidget {
  const RegisterEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleBar(
          screenName: "Registro",
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 51, 2, 44)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  "Crea tu cuenta ",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SimpleForm(
                  isLogIn: false,
                  route: "home",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
