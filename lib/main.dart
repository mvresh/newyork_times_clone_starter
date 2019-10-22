import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'network_helper.dart';
import 'article_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';

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
Future<Null> updatingNewsList()async{
  await Future.delayed(Duration(seconds:2));
    NetworkHelper helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d73aacc5bf514debb3377163552e3d98');
    headlinesData = await helper.getTopHeadlines();
  setState(() {

  });
 print('updating news...');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,centerTitle: true,
        title: Text(
          'MVR Times',
          style: TextStyle(
              fontSize: 32, color: Colors.black, fontFamily: 'OldLondon'),
        ),
      ),
      body: Container(
        child: RefreshIndicator(
          onRefresh: updatingNewsList,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: articleList.totalResults,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              var article = articleList.articles[index];
              return GestureDetector(
                onTap: (){
//                _launchURL(url) async {
//
//                  if (await canLaunch(url)) {
//                    await launch(url,forceWebView: true);
//                  } else {
//                    throw 'Could not launch ${url}';
//                  }
//                }
//                _launchURL(article.url);
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) => NewsDetailsPage(article)));
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(article.title,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontFamily: 'Noto',
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Text(
                                article.description,
                                maxLines: 4,
                                style: TextStyle(fontFamily: 'Noto',fontSize: 15,)
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Hero(
                                tag:article.urlToImage,
                                child: Image(
                                  fit: BoxFit.fitHeight,
                                  image: NetworkImage(
                                      article.urlToImage) ?? AssetImage('assets/image-placeholder.jpg'),
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
                                child: Text('${article.source.name}     ${DateTime.now().difference(DateTime.parse(article.publishedAt)).inHours} hours ago',
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
      ),
    );
  }
}

class NewsDetailsPage extends StatefulWidget {
  final Articles article;
  NewsDetailsPage(this.article);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'BBC News',
          style: TextStyle(color: Colors.grey, fontSize: 25,fontFamily: 'Noto'),
        ),
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions: <Widget>[
          Icon(
            Icons.share,
            color: Colors.grey,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //title
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(widget.article.title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,fontFamily: 'Noto',fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
            ),
//            description
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(widget.article.description,
                  style: TextStyle(fontSize: 20,fontFamily: 'Noto')),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) => ImageScreen(widget.article.urlToImage)));
                },
                child: Hero(
                  tag: widget.article.urlToImage,
                  child: Image(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        widget.article.urlToImage),
                  ),
                ),
              )
            ),
//            image caption
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(
                    color: Colors.grey,fontFamily: 'Noto'),
              ),
            ),
//            source name
            Padding(
              padding: EdgeInsets.fromLTRB(10,10,0,5),
              child: Text("By ${widget.article.source.name}",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10,10,0,5),
              child: Text("${DateTime.parse(widget.article.publishedAt).day} - ${DateTime.parse(widget.article.publishedAt).month} - ${DateTime.parse(widget.article.publishedAt).year}",
                  style: TextStyle(
                      color: Colors.red,fontFamily: 'Noto',fontSize: 18)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10,10,10,0),
              child: Text("${widget.article.content}",
                  style: TextStyle(fontSize: 20,
                      color: Colors.black,fontFamily: 'Noto')),
            )
          ],
        ),
      ),
    );
  }
}


class ImageScreen extends StatefulWidget {
  final String imageURL;

  ImageScreen(this.imageURL);
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PhotoView(
          imageProvider: NetworkImage(widget.imageURL),

        ),
      ),
    );
  }
}

