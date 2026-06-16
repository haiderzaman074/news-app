import 'package:flutter/material.dart';
import 'package:news_app/Model/showmodel.dart';
import 'package:news_app/Screen/showcategory.dart';
import 'package:news_app/Services/show_cate_news_data.dart';

class CategoriesNews extends StatefulWidget {
  String? name;
  CategoriesNews({this.name, super.key});

  @override
  State<CategoriesNews> createState() => _CategoriesNewsState();
}

class _CategoriesNewsState extends State<CategoriesNews> {
  List<ShowCateModel> categories = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getCategory();  // Fetch data on initialization
  }

  getCategory() async {
    ShowCategoryData showCategoryData = ShowCategoryData();
    await showCategoryData.getCategoryNews(widget.name);  // Fetch news by category
    setState(() {
      categories = showCategoryData.categories;  // Set fetched categories
      _loading = false;  // Stop loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            Text(' News', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ShowCategory(
            image: categories[index].urlToImage ?? '',  // Image URL (may be null)
            title: categories[index].Title ?? 'No title',  // Title (fallback text)
            decs: categories[index].description ?? 'No description',  // Description (fallback text)
          );
        },
      ),
    );
  }
}
