class BasketModel {
  int? id;
  String? title;
  double? price;
  String? image;
  int? count;

  BasketModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.count,
  });

  factory BasketModel.fromJson(Map<String, dynamic> json) {
    return BasketModel(
      id: json["id"] as int?,
      title: json["title"] as String?,
      price: double.tryParse(json['price'].toString()) ?? 0,
      image: json["image"] as String?,
      count: json["count"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'count': count,
    };
  }
}
