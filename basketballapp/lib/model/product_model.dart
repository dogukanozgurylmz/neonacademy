import 'package:basketballapp/model/rating_model.dart';

class ProductModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  RatingModel? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"] as int?,
      title: json["title"] as String?,
      price: double.tryParse(json['price'].toString()) ?? 0,
      description: json["description"] as String?,
      category: json["category"] as String?,
      image: json["image"] as String?,
      rating: RatingModel.fromJson(json["rating"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating!.toJson(),
    };
  }
}
