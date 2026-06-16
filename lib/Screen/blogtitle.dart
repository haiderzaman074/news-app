import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Screen/articles_view.dart';

class Blogtitle extends StatelessWidget {
  final String? title, desc, urlToImage,url;

  Blogtitle({required this.title, required this.desc,
    required this.urlToImage,required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to LandingScreen and pass data
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            LandingScreen(blogurl: url)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 3.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 120,
                height: 150,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                ),
                child: CachedNetworkImage(imageUrl:urlToImage!, fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: const BoxDecoration(),
                    child: Text(
                      title!,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.7,
                    decoration: const BoxDecoration(),
                    child: Text(
                      '$desc',
                      maxLines: 3,
                      style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black38),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
