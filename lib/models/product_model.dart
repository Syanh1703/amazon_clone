import 'dart:convert';

import 'package:amazon_clone/models/rating_model.dart';

class ProductModel {
  final String name;
  final String des;
  final double price;
  final int quantity;
  final String category;
  final List<String> images;
  final String? id;

  //rating
  final List<RatingModel>? rating;

  ProductModel({
    required this.name,
    required this.des,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'des': des,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      'id': id,
      'rating': rating
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        name: map['name'] ?? '',
        des: map['des'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        quantity: map['quantity']?.toInt() ?? 0,
        category: map['category'] ?? '',
        images: List<String>.from(map['images']),
        id: map['_id'],

        //Insert the rating to the product
        rating: map['ratings'] != null
            ? List<RatingModel>.from(
                map['ratings']?.map(
                  (x) => RatingModel.fromMap(x),
                ),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
