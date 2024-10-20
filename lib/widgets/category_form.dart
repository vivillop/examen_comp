import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';

class CategoryForm extends StatelessWidget {
  const CategoryForm({super.key});
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    final category = categoryForm.category;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 246, 205, 244),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Form(
        key: categoryForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          keyboardType: TextInputType.text,
          initialValue: category.categoryName,
          decoration: InputDecoration(
            labelText: "Nombre de la Categoría",
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.cyan),
            ),
          ),
          onChanged: (value) => category.categoryName = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Nombre inválido';
            }
            return null;
          },
        ),
      ),
    );
  }
}
