import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/screens/product_detail_screen.dart';
import 'package:amazon_clone/services/home_service.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class CategoriesDealScreen extends StatefulWidget {
  static const String categoryScreenRoute = '/category-deals';

  final String category;
  CategoriesDealScreen({required this.category});

  @override
  State<CategoriesDealScreen> createState() => _CategoriesDealScreenState();
}

class _CategoriesDealScreenState extends State<CategoriesDealScreen> {

  final HomeService homeService = HomeService();
  List<ProductModel>? productList;

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    productList = await homeService.fetchCategory(context: context, category: widget.category);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVars.featureScreen(widget.category),
      body: productList == null ? const Loader() : Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text('Keep shopping on ${widget.category}', style: const TextStyle(
              fontSize: 20,
            ),
            ),
          ),
          //31_07: Detail of the category
          SizedBox(
            height: 200,
            child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.4,
                mainAxisSpacing: 10,
                  ),
                itemBuilder: (ctx, index) {
                    final product = productList![index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, ProductDetailScreen.productDetailRouteName, arguments: product);
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 130,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12, width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.network(product.images[0]),
                              ),
                          ),
                          ),
                          //Display the product name
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis,),
                          ),
                        ],
                      ),
                    );
                },
              itemCount: productList!.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15, top: 10),
            ),
          ),
        ],
      ),
    );
  }
}
