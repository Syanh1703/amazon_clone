import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/screens/categories_deal_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(String category, BuildContext context){
    Navigator.pushNamed(context, CategoriesDealScreen.categoryScreenRoute, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: GlobalVars.categoryImages.length,
        itemExtent: 80,
        itemBuilder: (ctx, index) {
           return GestureDetector(
             onTap: () => navigateToCategoryPage(GlobalVars.categoryImages[index]['title']!, context),
             child: Column(
               children: <Widget>[
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(50),
                     child: Image.asset(GlobalVars.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                       height: 50,
                       width: 50,
                     ),
                   ),
                 ),
                 Text('${GlobalVars.categoryImages[index]['title']}', style: const TextStyle(
                   fontSize: 12,
                 ),
                 ),
               ],
             ),
           );
        },
      ),
    );
  }
}
