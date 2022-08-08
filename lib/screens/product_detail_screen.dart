import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/services/product_detail_service.dart';
import 'package:amazon_clone/widgets/common/custom_button.dart';
import 'package:amazon_clone/widgets/common/custom_rating_star.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String productDetailRouteName = '/product-detail';
  final ProductModel product;
  ProductDetailScreen({required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final productDetailService = ProductDetailService();
  double avgRating = 0;
  double myRating = 0;

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.searchScreenRouteName, arguments: query);
  }

  void addToCart(){
    productDetailService.addToCart(ctx: context, product: widget.product);
    print('Add ${widget.product.name} success');
  }

  Widget spaceShade(){
    return Container(
      height: 5,
      padding: const EdgeInsets.only(top: 2),
      color: Colors.black12,
    );
  }

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    int numberOfRating = widget.product.rating!.length;
    for(int i = 0; i<numberOfRating; i++){
      totalRating += widget.product.rating![i].rating;

      //Check the authentication
      if(widget.product.rating![i].userId == Provider.of<UserProvider>(context, listen: false).user.id){
          myRating = widget.product.rating![i].rating;
      }
    }

    if(totalRating != 0){
      avgRating = totalRating/(numberOfRating);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: GlobalVars.homeScreenCommon((query) => navigateToSearchScreen),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget> [
                      Text('${widget.product.id}'),
                      CustomRatingStars(rating: avgRating),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Text(widget.product.name, style: const TextStyle(
                      fontSize: 20,
                    ),
                    ),
                ),
                CarouselSlider(
                    items: widget.product.images.map((index) {
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: Builder(
                            builder: (BuildContext ctx) => Image.network(index, fit: BoxFit.contain, height: 200)
                        ),
                      );
                    }
                    ).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 300,
                    )
                ),
                spaceShade(),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: RichText(
                      text: TextSpan(
                        text: 'Deal Price: ', style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                        children: [
                          TextSpan(
                            text: '\$${widget.product.price}', style: const TextStyle(
                              fontSize: 22,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w500
                          ),
                          ),
                        ],
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(widget.product.des, style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                  ),
                ),
                spaceShade(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(buttonText: 'Buy Now', onTap: () {
                  }),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(buttonText: 'Add to Cart', onTap: addToCart,
                    color: Colors.yellow,
                    textColor: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                spaceShade(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Rate this product', style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RatingBar.builder(
                      initialRating: myRating,//base on the user average rating
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true, //allow 2.5 or 3.5 stars
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (ctx, _) => const Icon(Icons.star,color: GlobalVars.secondaryColor,),
                      onRatingUpdate: (rating) {
                        productDetailService.rateProduct(ctx: context,
                            product: widget.product,
                            rating: rating);
                      }),
                ),
              ],
            ),
          ),
    );
  }
}
