class CartModels {
  String? category;
  String? image;

  CartModels({
    required this.category,
    required this.image,
  });

  factory CartModels.fromJson(Map<String, dynamic> json) {
    return CartModels(
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'image': image,
    };
  }
}
