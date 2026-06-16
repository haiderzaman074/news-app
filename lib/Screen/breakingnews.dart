import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/slider_model.dart';
import 'package:news_app/Services/Slider_data.dart';

class Breakingnews extends StatefulWidget {
  final String? title, desc, img;
  const Breakingnews({this.title, this.img, this.desc, super.key});

  @override
  State<Breakingnews> createState() => _BreakingnewsState();
}

class _BreakingnewsState extends State<Breakingnews> {
  List<SliderModel> sliders = [];
  bool _loading = true;

  getSlider() async {
    SliderData slider = SliderData();
    await slider.getNews();
    sliders = slider.sliders;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getSlider();
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
            Text('Breaking', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            Text(' News', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: sliders.length,
        itemBuilder: (context, index) {
          return BreakingNewsItem(
            img: sliders[index].urlToImage ?? '',
            title: sliders[index].Title ?? 'No title',
            desc: sliders[index].description ?? 'No description',
          );
        },
      ),
    );
  }
}

class BreakingNewsItem extends StatelessWidget {
  final String img, title, desc;
  const BreakingNewsItem({required this.img, required this.title, required this.desc, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: img,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              desc,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}