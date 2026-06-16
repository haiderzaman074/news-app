import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/artical_model.dart';
import 'package:news_app/Screen/trendind_view.dart';
import 'package:news_app/Services/news_api.dart';

class TrendingNews extends StatefulWidget {
  const TrendingNews({super.key});

  @override
  State<TrendingNews> createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  List<ArticalModel> articles = [];
  bool _loading = true;

  getNews() async {
    NewsApi newsClass = NewsApi();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
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
            Text('Trending', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            Text(' News', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return TrendNewsBlog(
            title: articles[index].Title ?? 'No title',
            desc: articles[index].description ?? 'No description',
            urlToImage: articles[index].urlToImage ?? '',
            url: articles[index].url ?? '',
          );
        },
      ),
    );
  }
}

class TrendNewsBlog extends StatelessWidget {
  final String title, desc, urlToImage, url;

  const TrendNewsBlog({
    required this.title,
    required this.desc,
    required this.urlToImage,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrendingView(blogurl: url),
          ),
        );
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: CachedNetworkImage(
                  imageUrl: urlToImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Text(
                      title,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Text(
                      desc,
                      maxLines: 3,
                      style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}