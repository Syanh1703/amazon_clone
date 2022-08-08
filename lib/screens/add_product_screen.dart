import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/services/admin_service.dart';
import 'package:amazon_clone/widgets/common/custom_button.dart';
import 'package:amazon_clone/widgets/common/custom_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';

class AddProductScreen extends StatefulWidget {
  static const String addProductScreenRoute = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  //31_07: Add the post request function
  final AdminService adminService = AdminService();

  //Global Key to validate the form
  final _addProductKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _desController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  final List<String> _productCategories = [
    'Mobiles',
    'Appliances',
    'Electronics',
    'Essentials',
    'Fashion',
    'Entertainment',
  ];

  String _category = 'Mobiles';
  List<File> images = [];

  void sellProduct(){
    if(_addProductKey.currentState!.validate() && images.isNotEmpty){
      adminService.sellProducts(ctx: context, name: _productNameController.text, des: _desController.text,
          price:  double.parse(_priceController.text),
          quantity: double.parse(_quantityController.text),
          category: _category,
          images: images);
    }
  }

  void selectProductImages() async {
    var result = await pickImages();
    setState(() {
        images = result;
    });
    print('User pick image successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVars.featureScreen('Add Product'),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Form(
            key: _addProductKey,
            child: Column(
              children: <Widget>[
                images.isNotEmpty ? CarouselSlider(
                    items: images.map((index) {
                      return Builder(
                          builder: (BuildContext ctx) => Image.file(index, fit: BoxFit.cover, height: 200,));
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 200,
                    ),
                ): GestureDetector(
                    onTap: selectProductImages,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [8,4],
                      strokeCap: StrokeCap.round,
                      strokeWidth: 1,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(Icons.folder_open_outlined, size: 40,),
                              const SizedBox(height: 10,),
                              Text('Select Product Images',style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade400
                              ), )
                            ],
                          ),
                        ),
                    ),
                  ),
                const SizedBox(height: 20,),
                CustomFormField(_productNameController, 'Product Name', 1, 'Product name must not be empty'),
                const SizedBox(height: 10,),
                CustomFormField(_desController, 'Product Description', 7, 'This filed must not be empty'),
                const SizedBox(height: 10,),
                CustomFormField(_priceController, 'Price per product', 1, 'This field must be larger than 0'),
                const SizedBox(height: 10,),
                CustomFormField(_quantityController, 'Product Quantity', 1, 'This filed must be larger than 0'),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: _category,
                      items: _productCategories.map((String index) {
                        return DropdownMenuItem(
                            value: index,
                            child: Text(index),
                        );
                      }).toList(),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (String? value) {
                        setState(() {
                          _category = value!;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                CustomButton(buttonText: 'Upload Product', onTap: sellProduct),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
