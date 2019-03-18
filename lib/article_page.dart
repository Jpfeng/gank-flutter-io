import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'home_page.dart';

class ArticlePage extends StatefulWidget {
  final Article _data;

  ArticlePage(this._data);

  @override
  State<StatefulWidget> createState() {
    return _ArticleState(_data);
  }
}

class _ArticleState extends State<ArticlePage> {
  Article _data;

  _ArticleState(this._data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_data.desc),
      ),
      body: WebView(
        initialUrl: _data.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
