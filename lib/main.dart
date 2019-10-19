import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'network_helper.dart';
import 'article_list.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(
      home: LoadingPage(),
    ));



Map<String, dynamic> headlinesData;

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    getHeadlines();
  }

  void getHeadlines() async {
    NetworkHelper helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d73aacc5bf514debb3377163552e3d98');
    headlinesData = await helper.getTopHeadlines();
    Navigator.pushReplacement((context),
        MaterialPageRoute(builder: (context) => NewsListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(width: 50,height: 50,child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.green),strokeWidth: 5,)),
      ),
    );
  }
}

class NewsListPage extends StatefulWidget {

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

ArticleList articleList = ArticleList.fromJson(headlinesData);

class _NewsListPageState extends State<NewsListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'MVR Times',
          style: TextStyle(
              fontSize: 32, color: Colors.black, fontFamily: 'OldLondon'),
        ),
      ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: articleList.totalResults,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var article = articleList.articles[index];
            return GestureDetector(
              onTap: (){
                _launchURL(url) async {

                  if (await canLaunch(url)) {
                    await launch(url,forceWebView: true);
                  } else {
                    throw 'Could not launch ${url}';
                  }
                }
                _launchURL(article.url);
              },
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Text(article.title,
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Text(
                              article.description,
                              maxLines: 4,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: 100,
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    article.urlToImage),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: Text('${article.source.name}',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.share),
                                Icon(Icons.bookmark_border)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
