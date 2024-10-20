import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/widgets.dart';

class LoginEmailScreen extends StatelessWidget {
  const LoginEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 52, 3, 47)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const TitleBar(
          screenName: "Iniciar sesión",
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: SimpleForm(
                isLogIn: true,
                resetPassword: true,
                route: "home",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
