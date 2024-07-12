import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/model/product_model.dart';
import 'package:smart_shop/provider/api_product_provider.dart';
import 'package:smart_shop/shared/string_const.dart';

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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 16,),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText:StringConst.addLabelName,
                    hintText: StringConst.addLabelName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                    labelText:StringConst.addLabelPrice,
                    hintText: StringConst.addLabelPrice,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText:StringConst.addLabelDesc,
                    hintText: StringConst.addLabelDesc,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                TextFormField(
                  controller: categoryController,
                  decoration: InputDecoration(
                    labelText:StringConst.homeCategory,
                    hintText: StringConst.addLabelCategory,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<ApiProductProvider>(
                  builder: (context, productProvider, child) {
                    return isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          setState(() {
                            isLoading = true;
                          });

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
                            print('Error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${StringConst.errorAdd}: $e')),
                            );
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
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
