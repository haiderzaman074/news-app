import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/showmodel.dart';

class ShowCategoryData {
  List<ShowCateModel> categories = [];

  Future<void> getCategoryNews(String? category) async {
    // String url= 'https://newsapi.org/v2/top-headlines?country=pk&category=business&apiKey=YOUR_API_KEY';
    String url = 'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=195edc7bec0a49f39d253b85c4153a32';

    var response = await http.get(Uri.parse(url));

    var Jsondata = jsonDecode(response.body);

    // Check if the status is 'ok'
    if (Jsondata['status'] == 'ok') {
      Jsondata["articles"].forEach((elements) {
        if (elements["urlToImage"] != null && elements["description"] != null) {  // Fixed here: removed leading space
          ShowCateModel showcateModel = ShowCateModel(
            Title: elements["title"],
            description: elements["description"],
            content: elements["content"],
            url: elements["url"],
            author: elements["author"],
            urlToImage: elements["urlToImage"],
          );
          categories.add(showcateModel);
        }
      });
    }
  }
}
