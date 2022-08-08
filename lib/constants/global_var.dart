import 'package:flutter/material.dart';

String uri = 'http://10.0.2.2:3000';

class GlobalVars {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const iconThemeColor = Colors.black;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/image/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/image/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/image/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/image/entertainment.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/image/fashion.jpeg',
    },
    {
      'title': 'Electronics',
      'image': 'assets/image/electronics.jpeg',
    }
  ];

  static PreferredSize screenCommon(String name){
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVars.appBarGradient,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/image/amazon_in.png',
                width: 120,
                height: 40,
                color: Colors.black,
              ),
            ),
              Text(name, style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),)
          ],
        ),
      ),
    );
  }

  static PreferredSize featureScreen(String name){
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVars.appBarGradient,
          ),
        ),
        title: Text(name, style: const TextStyle(
          color: Colors.black
        ),),
      ),
    );
  }

  static PreferredSize homeScreenCommon(Function(String query) navigateToSearchScreen){
    return PreferredSize(
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
    );
  }
}
