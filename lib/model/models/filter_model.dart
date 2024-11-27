class FilterModel {
  String? category;
  String? image;
  FilterModel({
    required this.category,
    required this.image,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(category: json['strMeal'], image: json['strMealThumb']);
  }
}
