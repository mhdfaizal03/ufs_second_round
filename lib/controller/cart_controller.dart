import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_catalog/model/models/cart_models.dart';
import 'package:food_catalog/utils/widgtes/custom_widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  RxList cartModel = <CartModels>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    loadCart();
    super.onInit();
  }


 // add function on cart to shared preferences 

  Future<void> addToCart(CartModels item, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? cartItems = prefs.getStringList('cart') ?? [];
      cartItems.add(jsonEncode(item.toJson()));
      await prefs.setStringList('cart', cartItems);
    } catch (e) {
      customSnackbar(context, 'Something went wrong $e');
    }
  }


  // load items from shared preferences to cart screen

  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? storedItems = prefs.getStringList('cart');

      if (storedItems != null) {
        cartModel.value = storedItems
            .map((item) => CartModels.fromJson(jsonDecode(item)))
            .toList();
      }
    } catch (e) {
      log(e.toString());
    }
  }


  // update for shared preferences when user delete the data from cart

  Future<void> updateCart(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
          'cart', cartModel.map((item) => jsonEncode(item.toJson())).toList());
    } catch (e) {
      customSnackbar(context, 'Something went wrong $e');
    }
  }
}
