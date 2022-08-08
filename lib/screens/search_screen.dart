import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/screens/product_detail_screen.dart';
import 'package:amazon_clone/services/search_service.dart';
import 'package:amazon_clone/widgets/address_box.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:amazon_clone/widgets/searched_product.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class SearchScreen extends StatefulWidget {
  static const String searchScreenRouteName = '/search-screen';
  final String query;
  SearchScreen({required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchService = SearchService();
  List<ProductModel>? products;

  fetchSearchedProducts() async {
    products = await searchService.fetchSearchedProduct(context: context, searchQuery: widget.query);
    setState(() {});
  }

  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.searchScreenRouteName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    fetchSearchedProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVars.homeScreenCommon((navigate) => navigateToSearchScreen),
      body: products == null ? const Loader(): Column(
        children: <Widget>[
            const AddressBox(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ProductDetailScreen.productDetailRouteName, arguments: products![index]);
                },
                  child: SearchedProduct(product: products![index],));
            },
              itemCount: products!.length,
            ),
          ),
        ],
      ),
    );
  }
}


