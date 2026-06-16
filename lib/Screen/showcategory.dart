import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowCategory extends StatelessWidget {
  String? image,title,decs;
   ShowCategory({super.key,required this.image,required this.title,required this.decs,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:image!,height: 200,width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          ),
          Text(title!,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
          Text(decs!,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.normal),)
        ],
      ),
    );
  }
}
