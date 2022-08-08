import 'package:amazon_clone/constants/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingStars extends StatelessWidget {
  final double rating;
  CustomRatingStars({required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(itemBuilder: (ctx, _) => const Icon(Icons.star, color: GlobalVars.secondaryColor,),
      direction: Axis.horizontal,
      itemCount: 5, //How many stars to show on screen
      rating: rating,
      itemSize: 15,
    );
  }
}
