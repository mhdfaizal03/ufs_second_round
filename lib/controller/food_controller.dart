import 'package:food_catalog/model/services/api_services.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
  RxList foodList = [].obs;
  RxBool isLoading = false.obs;
  RxBool filterData = false.obs;

  final dropdownvalue = 'Beef'.obs;

  var items = [
    'Beef',
    'Chicken',
    'Dessert',
    'Pasta',
    'Miscellaneous',
    'Pork',
    'Seafood',
    'Side',
    'Starter',
    'Vegan',
    'Vegetarian',
    'Breakfast',
    'Goat',
  ];

  // when click on dropdown

  String clickDropDown(String newVal) {
    dropdownvalue.value = newVal;
    filteredData(newVal.toString());
    return dropdownvalue.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    // getData();
    filterData.value ? getData() : filteredData(dropdownvalue.value);
    super.onInit();
  }

  //gets data from apiservice class

  void getData() async {
    isLoading.value = true;
    final data = await ApiServices().fetchDatafromApi();
    if (data != null) {
      foodList.value = data;
      isLoading.value = false;
    }
  }


  // filter check data from apiservice class

  void filteredData(String filterText) async {
    isLoading.value = true;

    final data = await ApiServices().filterDatafromApi(filterText);
    if (data != null) {
      foodList.value = data;
      isLoading.value = false;
    }
  }
}
