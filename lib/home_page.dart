import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'article_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List _data = new List();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('随机文章'),
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: _load,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Widget getBody() {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : Scrollbar(
            child: ListView.separated(
              itemCount: null == _data ? 0 : _data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () =>
                      toArticle(context, Article.fromJson(_data[index])),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(Article.fromJson(_data[index]).desc),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  color: Colors.grey,
                );
              },
            ),
          );
  }

  void toArticle(BuildContext context, Article data) {
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new ArticlePage(data),
        ));
  }

  void _load() async {
    String dataURL = "http://gank.io/api/random/data/Android/20";
    setState(() {
      _loading = true;
    });
    var response = await http.get(dataURL);
    setState(() {
      _data = json.decode(response.body)['results'];
      _loading = false;
    });
  }
}

class Article {
  String id;
  String createdAt;
  String desc;
  List images;
  String publishedAt;
  String source;
  String type;
  String url;
  bool used;
  String who;

  Article.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        createdAt = json['createdAt'],
        desc = json['desc'],
        images = json['images'],
        publishedAt = json['publishedAt'],
        source = json['source'],
        type = json['type'],
        url = json['url'],
        used = json['used'],
        who = json['who'];
}
