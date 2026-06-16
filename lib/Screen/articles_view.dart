import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LandingScreen extends StatefulWidget {
  final String? blogurl;

  const LandingScreen({
    required this.blogurl,
    super.key,
  });

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.blogurl ?? 'https://flutter.dev'));
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
            Text('Flutter',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Text(' News',
                style: TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
