import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_catalog/controller/cart_controller.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    instanceFromGet.loadCart();
    super.initState();
  }

  final instanceFromGet = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white30,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Cart Items',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Obx(
          () => instanceFromGet.cartModel.isEmpty
              ? const Center(
                  child: Text(
                    'No items in cart',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: instanceFromGet.cartModel.length,
                  itemBuilder: (context, index) {
                    final indexedCartItems = instanceFromGet.cartModel[index];
                    return Card(
                      child: SizedBox(
                        height: 80,
                        width: double.infinity,
                        child: Center(
                          child: ListTile(
                            title: Text(indexedCartItems.category.toString()),
                            leading: Image.network(
                                indexedCartItems.image.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  instanceFromGet.cartModel.removeAt(index);
                                  instanceFromGet.updateCart(context);
                                },
                                icon: const Icon(CupertinoIcons.delete)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ));
  }
}
