import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/model/product_model.dart';
import 'package:smart_shop/provider/api_product_provider.dart';
import 'package:smart_shop/shared/string_const.dart';
import 'package:smart_shop/shared/widget/reuse_text_form_field.dart';

class UpdateProductScreen extends StatefulWidget {
  final ProductModel product;

  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name;
    descController.text = widget.product.description;
    priceController.text = widget.product.price.toString();
    categoryController.text = widget.product.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.updateProduct),
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
                isLoading
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
                      ProductModel updateProduct = ProductModel(
                        id: widget.product.id,
                        name: productName,
                        price: productPrice,
                        category: productCategory,
                        description: productDesc,
                      );

                      try {
                        await Provider.of<ApiProductProvider>(context, listen: false)
                            .updateProduct(widget.product.id, updateProduct);
                        Navigator.pop(context);
                      } catch (e) {
                        print('Error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${StringConst.errorUpdate}: $e')),
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    }
                  },
                  child: const Text(StringConst.updateProduct),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
