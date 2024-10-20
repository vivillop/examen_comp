import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
import 'package:examen_vvl/screen/screen.dart';

class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    if (categoryService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: UpperBar(
          screenName: "Categorías",
          child: GestureDetector(
            onTap: () {
              categoryService.selectProduct = ListadoCategoria(
                  categoryId: 0, categoryName: "Categoría", categoryState: "");
              Navigator.pushNamed(context, "editCategory");
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
          itemCount: categoryService.categories.length,
          itemBuilder: (context, index) {
            final ListadoCategoria category = categoryService.categories[index];
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, "category",
                  arguments: {"category": category}),
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
                    Text(
                      category.categoryName,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    EditButtonWidget(
                      onPressed: () {
                        categoryService.selectProduct = category;
                        Navigator.pushNamed(context, "editCategory");
                      },
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
