import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/screens/product_detail_screen.dart';
import 'package:amazon_clone/services/home_service.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  final homeService = HomeService();
  ProductModel? product;
  @override
  void initState() {
    fetchDealOfDay();
    super.initState();
  }

  fetchDealOfDay() async {
      product = await homeService.fetchDealOfDay(context: context);
      setState(() {});
  }

  void navigateToDetailScreen(){
    Navigator.pushNamed(context, ProductDetailScreen.productDetailRouteName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null ? const Loader() :
    product!.name.isEmpty ? const SizedBox() :
    GestureDetector(
      onTap: navigateToDetailScreen,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: const Text('Deal of the day', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),),
          ),
          const SizedBox(height: 10,),
          Padding(padding: const EdgeInsets.all(8),
            child: Image.network(product!.images[0],
              height: 235,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
            child: const Text(
              'Sy Anh', maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
            child: const Text(
              '\$99.00', maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: product!.images.map((img) =>   //Product Images
              Image.network(img,
                height: 100,
                width: 100,
                fit: BoxFit.fitWidth,
              ),
              ).toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, top: 10, bottom: 15),
            alignment: Alignment.topLeft,
            child: Text('See all deals', style: TextStyle(
              color: Colors.cyan[800],
              fontSize: 18
            ),),
          ),
        ],
      ),
    );
  }
}
