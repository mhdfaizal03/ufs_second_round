import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_catalog/controller/cart_controller.dart';
import 'package:food_catalog/controller/food_controller.dart';
import 'package:food_catalog/model/models/cart_models.dart';
import 'package:food_catalog/view/screens/cart_screen.dart';
import 'package:get/get.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  final getController = Get.put(FoodController());
  final createData = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Food Catalog',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const CartScreen(),
                    transition: Transition.cupertino, curve: Curves.slowMiddle);
              },
              icon: const Icon(
                CupertinoIcons.cart,
                color: Colors.white,
              ))
        ],
      ),
      body: Obx(
        () => getController.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.2,
                  color: Colors.white38,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey),
                    child: DropdownButton<String>(
                      underline: const SizedBox(),
                      dropdownColor: Colors.grey,
                      icon: const Icon(CupertinoIcons.arrow_down_circle),
                      value: getController.dropdownvalue.value.toString(),
                      items: getController.items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newVal) =>
                          getController.clickDropDown(newVal!),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: getController.foodList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          final indexeddata = getController.foodList[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                              indexeddata.image.toString())),
                                      Text(
                                        indexeddata.category.toString(),
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {
                                        createData.addToCart(
                                            CartModels(
                                              category: indexeddata.category
                                                  .toString(),
                                              image:
                                                  indexeddata.image.toString(),
                                            ),
                                            context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Added to cart')));
                                      },
                                      icon: const Icon(
                                          CupertinoIcons.cart_badge_plus)),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
