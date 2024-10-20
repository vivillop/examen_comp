import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';

class EditProviderScreen extends StatelessWidget {
  const EditProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProviderFormProvider(providerService.selectProduct!),
      child: _ProviderScreenBody(providerService: providerService),
    );
  }
}

class _ProviderScreenBody extends StatelessWidget {
  const _ProviderScreenBody({
    required this.providerService,
  });

  final ProviderService providerService;

  @override
  Widget build(BuildContext context) {
    final providerForm = Provider.of<ProviderFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitleBar(screenName: "Editar proveedor"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: _ProviderForm(),
              ),
              GestureDetector(
                onTap: () async {
                  if (!providerForm.isValidForm()) return;
                  await providerService.editOrCreateProviders(
                      providerForm.provider, context);
                  if (!context.mounted) return;
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 116, 9, 98),
                  ),
                  child: const Text(
                    "Guardar",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 158, 219, 16)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  if (!providerForm.isValidForm()) return;
                  await providerService.deleteProvider(
                      providerForm.provider, context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 153, 11, 103),
                  ),
                  child: const Text(
                    "Eliminar",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 222, 186, 26)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProviderForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final providerForm = Provider.of<ProviderFormProvider>(context);
    final provider = providerForm.provider;
    return Form(
      key: providerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomTextField(
            label: "Nombre del Proveedor",
            initialValue: provider.providerName,
            onChanged: (value) => provider.providerName = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nombre inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Apellido del Proveedor",
            initialValue: provider.providerLastName,
            onChanged: (value) => provider.providerLastName = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Apellido inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Correo del Proveedor",
            initialValue: provider.providerMail,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => provider.providerMail = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Correo inválido';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
