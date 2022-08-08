import 'package:amazon_clone/screens/add_product_screen.dart';
import 'package:amazon_clone/services/admin_service.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductsManageScreen extends StatefulWidget {
  const ProductsManageScreen({Key? key}) : super(key: key);

  @override
  State<ProductsManageScreen> createState() => _ProductsManageScreenState();
}

class _ProductsManageScreenState extends State<ProductsManageScreen> {

  final AdminService adminService = AdminService();
  List<ProductModel>? productList;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  //Get all the products
  fetchAllProducts() async {
    productList = await adminService.fetchAllProducts(context);
    setState(() {});
  }

  void navigateToAddScreen(){
      Navigator.pushNamed(context, AddProductScreen.addProductScreenRoute);
  }

  //31_07: Delete product
  void deleteProduct(ProductModel productModel, int index){
    adminService.deleteProduct(context: context, product: productModel, onSuccess: (){
      productList!.removeAt(index);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return productList == null ? const Loader() : Scaffold(
      body: GridView.builder(
        itemCount: productList!.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          final productData = productList![index];
          return Column(
            children: <Widget>[
               SizedBox(
                height: 140,
                child: SingleProduct(
                  productData.images[0] //Display the first image of the image list
                ),
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: Text(productData.name, overflow: TextOverflow.ellipsis, maxLines: 2,),
                    ),
                    IconButton(onPressed: () => deleteProduct(productData, index),
                        icon: Icon(Icons.delete_outline)),
                  ],
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddScreen,
        tooltip: 'Add a new product',
        child: const Icon(Icons.add_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

