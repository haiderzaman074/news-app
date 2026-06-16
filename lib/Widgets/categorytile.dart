import 'package:flutter/material.dart';

import '../Screen/categories_news.dart';


class Categorytile extends StatelessWidget {
  final CategoryName,image;
  const Categorytile({
    required this.image,
    required this.CategoryName,
    super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
        CategoriesNews(name: CategoryName,)));
      },
      child: Container(
        width: 120,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.black26
        ),
        child: Stack(
          children: [
            Image(image: AssetImage(image,),width: 120,height: 70,fit: BoxFit.cover,),
            Container(
              alignment: Alignment.center,
              child: Center(
                child: Text(CategoryName,style: const TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
