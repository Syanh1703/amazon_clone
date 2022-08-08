import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/widgets/common/custom_rating_star.dart';
import 'package:flutter/material.dart';

class SearchedProduct extends StatelessWidget {
  final ProductModel product;

  SearchedProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    double avgRating = 0;
    double totalRating = 0;
    int numberOfRating = product.rating!.length;
    for (int i = 0; i < numberOfRating; i++) {
      totalRating += product.rating![i].rating;

      if (totalRating != 0) {
        avgRating = totalRating / (numberOfRating);
      }
    }

      Widget featureContainer(String content, double fontSize,
          FontWeight fontWeight) {
        return Container(
          width: 235,
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Text(content, style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight
          ),),
        );
      }
      return Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
            child: Row(
              children: <Widget>[
                Image.network(product.images[0], fit: BoxFit.contain,
                  height: 135,
                  width: 135,),

                ///Product Description
                Column(
                  children: <Widget>[
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(product.name, style: const TextStyle(
                        fontSize: 18,
                      ),
                        maxLines: 2,
                      ),
                    ),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: CustomRatingStars(rating: avgRating,),
                    ),
                    featureContainer('\$${product.price}', 20, FontWeight.bold),
                    featureContainer(
                        'Eligible for FREE Shipping', 16, FontWeight.normal),
                    Container(
                      width: 235,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text('In stock', style: TextStyle(
                          color: Colors.teal
                      ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
  }
}

