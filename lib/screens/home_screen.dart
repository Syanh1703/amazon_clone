import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/widgets/carousel_image.dart';
import 'package:amazon_clone/widgets/deal_of_the_day.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/global_var.dart';
import '../widgets/address_box.dart';
import '../widgets/top_categories.dart';

class HomeScreen extends StatefulWidget {
  static const String homeScreenRouteName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //navigate to search screen
  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.searchScreenRouteName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVars.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15, top: 10),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 2,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: (){

                          },
                          child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                            child: Icon(Icons.search, color: Colors.black, size: 23,),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(8),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        hintText: 'Search anything....',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                padding: const EdgeInsets.only(top: 12),
                margin: const EdgeInsets.all(10),
                child: const Icon(Icons.mic, size: 25,),
              ),
              ],
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBox(),
            SizedBox(height: 15,),
            TopCategories(),
            SizedBox(height: 10,),
            CarouselImage(),
            DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}

