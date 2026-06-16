import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/Model/artical_model.dart';

class NewsApi {
  List<ArticalModel> news = [];

  Future<void> getNews() async {
    String url = 'https://newsapi.org/v2/everything?q=apple&from=2025-05-18&to=2025-05-18&sortBy=popularity&apiKey=API_KEY';

    var response = await http.get(Uri.parse(url));

    var Jsondata = jsonDecode(response.body);

    // Check if the status is 'ok'
    if (Jsondata['status'] == 'ok') {
      Jsondata["articles"].forEach((elements) {
        if (elements["urlToImage"] != null && elements["description"] != null) {  // Fixed here: removed leading space
          ArticalModel articalModel = ArticalModel(
            Title: elements["title"],
            description: elements["description"],
            content: elements["content"],
            url: elements["url"],
            author: elements["author"],
            urlToImage: elements["urlToImage"],
          );
          news.add(articalModel);
        }
      });
    }
  }
}
