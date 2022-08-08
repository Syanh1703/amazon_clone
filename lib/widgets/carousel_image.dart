import 'package:amazon_clone/constants/global_var.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: GlobalVars.carouselImages.map((index) {
          return Padding(
            padding: const EdgeInsets.all(2),
            child: Builder(
                builder: (BuildContext ctx) => Image.network(index, fit: BoxFit.cover, height: 200)
            ),
          );
        }
        ).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
        )
    );
  }
}

