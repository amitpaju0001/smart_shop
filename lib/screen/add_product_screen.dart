import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/model/product_model.dart';
import 'package:smart_shop/provider/api_product_provider.dart';
import 'package:smart_shop/shared/string_const.dart';
import 'package:smart_shop/shared/widget/reuse_text_form_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.addProduct),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                ReuseTextFormField(
                  controller: nameController,
                  labelText: StringConst.addLabelName,
                  prefixIcon: Icons.label,
                ),
                const SizedBox(height: 10),
                ReuseTextFormField(
                  controller: priceController,
                  labelText: StringConst.addLabelPrice,
                  prefixIcon: Icons.money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ReuseTextFormField(
                  controller: descController,
                  labelText: StringConst.addLabelDesc,
                  prefixIcon: Icons.description,
                ),
                const SizedBox(height: 10),
                ReuseTextFormField(
                  controller: categoryController,
                  labelText: StringConst.homeCategory,
                  prefixIcon: Icons.category,
                ),
                const SizedBox(height: 16),
                Consumer<ApiProductProvider>(
                  builder: (context, productProvider, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          String productName = nameController.text;
                          String productDesc = descController.text;
                          int productPrice = int.parse(priceController.text);
                          String productCategory = categoryController.text;
                          ProductModel productModel = ProductModel(
                            id: '',
                            name: productName,
                            price: productPrice,
                            category: productCategory,
                            description: productDesc,
                          );

                          try {
                            await productProvider.addProduct(productModel);
                            Navigator.pop(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${StringConst.errorAdd}: $e')),
                            );
                          }
                        }
                      },
                      child: const Text(StringConst.addProduct),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
