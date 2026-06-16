import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TrendingView extends StatefulWidget {
  final String blogurl;

  const TrendingView({required this.blogurl, super.key});

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.blogurl));
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
      body: WebViewWidget(controller: _controller),
    );
  }
}
