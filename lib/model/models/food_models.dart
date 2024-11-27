class FoodModels {
  String? category;
  String? image;
  String? descreption;
  FoodModels({
    required this.category,
    required this.image,
    required this.descreption,
  });

  factory FoodModels.fromJson(Map<String, dynamic> json) {
    return FoodModels(
        category: json['strCategory'],
        image: json['strCategoryThumb'],
        descreption: json['strCategoryDescription']);
  }
}
