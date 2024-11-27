import 'dart:convert';
import 'dart:developer';

import 'package:food_catalog/model/models/filter_model.dart';
import 'package:food_catalog/model/models/food_models.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  var url = "https://www.themealdb.com/api/json/v1/1/categories.php";
  var filterUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c=";

  Future<List<FoodModels>?> fetchDatafromApi() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final category = body['categories'];
        print(response.body);
        List<FoodModels> model = [];

        for (var items in category) {
          model.add(FoodModels.fromJson(items));
        }

        return model;
      }
    } catch (e) {
      log('error :$e');
    }
    return null;
  }

  Future<List<FilterModel>?> filterDatafromApi(String category) async {
    try {
      final response = await http.get(Uri.parse(filterUrl + category));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final meals = body['meals'];
        print(response.body);
        List<FilterModel> model = [];

        for (var items in meals) {
          model.add(FilterModel.fromJson(items));
        }

        return model;
      }
    } catch (e) {
      log('error :$e');
    }
    return null;
  }
}
