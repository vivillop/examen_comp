import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../services/services.dart';

class SimpleForm extends StatelessWidget {
  final bool isLogIn;
  final bool resetPassword;
  final String route;
  const SimpleForm({
    super.key,
    required this.isLogIn,
    this.resetPassword = false,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChangeNotifierProvider(
          create: (_) => LoginFormProvider(),
          child: LoginForm(
            isLogIn: isLogIn,
            route: route,
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  final bool isLogIn;
  final String route;

  const LoginForm({
    super.key,
    required this.isLogIn,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return SingleChildScrollView(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: const Text("Ingrese su Correo electrónico"),
                contentPadding: const EdgeInsets.all(8),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : "Correo inválido";
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                label: const Text("Contraseña"),
                contentPadding: const EdgeInsets.all(8),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 4)
                    ? null
                    : 'Contraseña debe contener 6 carácteres.';
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              disabledColor: Colors.grey,
              color: const Color.fromARGB(255, 161, 42, 147),
              elevation: 0,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);
                      if (!loginForm.isValidForm()) return;
                      loginForm.isLoading = true;
                      if (isLogIn) {
                        final String? idToken = await authService.login(
                            loginForm.email, loginForm.password);
                        if (idToken != null) {
                          if (!context.mounted) return;
                          Navigator.pushNamed(context, route,
                              arguments: {"idToken": idToken});
                        }
                        loginForm.isLoading = false;
                      } else {
                        final String? idToken = await authService.register(
                            loginForm.email, loginForm.password);
                        if (idToken != null) {
                          if (!context.mounted) return;
                          Navigator.pushNamed(context, route,
                              arguments: {"idToken": idToken});
                        }
                        loginForm.isLoading = false;
                      }
                    },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                      color: Color.fromARGB(255, 40, 3, 36),
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
