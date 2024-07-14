import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_shop/provider/api_product_provider.dart';
import 'package:smart_shop/screen/add_product_screen.dart';
import 'package:smart_shop/screen/update_product_screen.dart';
import 'package:smart_shop/shared/string_const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future fetchProducts() async {
    final productProvider =
        Provider.of<ApiProductProvider>(context, listen: false);
    await productProvider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.homeApp),
        centerTitle: true,
      ),
      body: Consumer<ApiProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (context, index) {
              final product = productProvider.products[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            StringConst.homeName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.name,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            StringConst.homePrice,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            product.price.toString(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            StringConst.homeCategory,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              product.category,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        StringConst.homeDesc,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.description,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateProductScreen(
                                        product: product);
                                  },
                                )).then((_) {
                                  fetchProducts();
                                });
                              },
                              child: const Text(StringConst.homeUpdate)),
                          TextButton(
                              onPressed: () async {
                                bool? confirmed = await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(StringConst.dialogDelete),
                                      content: const Text(
                                          StringConst.dialogDeleteDesc),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text(StringConst.dialogCancel),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text(StringConst.dialogConfirm),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (confirmed == true) {
                                  await Provider.of<ApiProductProvider>(context,listen: false).deleteProduct(product.id);
                                }
                              },
                              child: const Text(StringConst.homeDelete)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
     floatingActionButton: FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const AddProductScreen();
          },
        )).then((_) {
          fetchProducts();
        });
      },
      child: const Icon(Icons.add),
    ),
    );
  }
}
