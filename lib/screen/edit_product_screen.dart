import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final selectedProduct = productService.selectProduct;

    if (selectedProduct == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text("Producto no seleccionado"),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    required this.productService,
  });

  final ProductService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitleBar(screenName: "Editar producto"),
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
              SizedBox(
                height: 300,
                child: Image(
                  image:
                      NetworkImage(productService.selectProduct!.productImage),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: _ProductForm(),
              ),
              GestureDetector(
                onTap: () async {
                  if (!productForm.isValidForm()) return;
                  await productService.editOrCreateProduct(
                      productForm.product, context);
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
                      color: Color.fromARGB(255, 158, 219, 16),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  if (!productForm.isValidForm()) return;
                  await productService.deleteProduct(
                      productForm.product, context);
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
                      color: Color.fromARGB(255, 222, 186, 26),
                    ),
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

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Form(
      key: productForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomTextField(
            label: "Nombre de Producto",
            initialValue: product.productName,
            onChanged: (value) => product.productName = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nombre inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Valor",
            initialValue: product.productPrice.toString(),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              if (int.tryParse(value) == null) {
                product.productPrice = 0;
              } else {
                product.productPrice = int.parse(value);
              }
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Dirección Url de la imagen",
            initialValue: product.productImage,
            keyboardType: TextInputType.url,
            onChanged: (value) => product.productImage = value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'URL inválida';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
