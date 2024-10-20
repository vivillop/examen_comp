import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
import 'package:examen_vvl/screen/screen.dart';

class ListProductScreen extends StatelessWidget {
  const ListProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    if (productService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: UpperBar(
          screenName: "Productos",
          child: GestureDetector(
            onTap: () {
              productService.selectProduct = Listado(
                  productId: 0,
                  productName: "Producto",
                  productPrice: 4000,
                  productImage:
                      "https://imagedelivery.net/4fYuQyy-r8_rpBpcY7lH_A/falabellaCL/17187480_1/w=1500,h=1500,fit=pad",
                  productState: "");
              Navigator.pushNamed(context, "editProduct");
            },
            child: const Icon(
              Icons.add,
              size: 24,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: ListView.builder(
          itemCount: productService.products.length,
          itemBuilder: (context, index) {
            final Listado product = productService.products[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, "product",
                  arguments: {"product": product}),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 140,
                      child: Image(
                        image: NetworkImage(product.productImage),
                      ),
                    ),
                    Text(
                      product.productName,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    EditButtonWidget(
                      onPressed: () {
                        productService.selectProduct = product;
                        Navigator.pushNamed(context, "editProduct");
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "\$${product.productPrice}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
