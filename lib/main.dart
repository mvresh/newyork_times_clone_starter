import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'network_helper.dart';
import 'article_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

void main() => runApp(MaterialApp(
      home: LoadingPage(),
    ));

Map<String, dynamic> headlinesDataBBC;
Map<String, dynamic> headlinesDataARS;
Map<String, dynamic> headlinesDataCNBC;
Map<String, dynamic> headlinesDataALJ;
Map<String, dynamic> headlinesDataENG;
Map<String, dynamic> headlinesDataBND;

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
    NetworkHelper BBC_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper ARS_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=ars-technica&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper CNBC_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=cnbc&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper ALJ_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=al-jazeera-english&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper ENG_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=engadget&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper BND_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=business-insider&apiKey=d73aacc5bf514debb3377163552e3d98');
    headlinesDataBBC = await BBC_helper.getTopHeadlines();
    headlinesDataARS = await ARS_helper.getTopHeadlines();
    headlinesDataCNBC = await CNBC_helper.getTopHeadlines();
    headlinesDataALJ = await ALJ_helper.getTopHeadlines();
    headlinesDataENG = await ENG_helper.getTopHeadlines();
    headlinesDataBND = await BND_helper.getTopHeadlines();
    Navigator.pushReplacement(
        (context), MaterialPageRoute(builder: (context) => NewsListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              strokeWidth: 5,
            )),
      ),
    );
  }
}

class NewsListPage extends StatefulWidget {

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

ArticleList articleListBBC = ArticleList.fromJson(headlinesDataBBC);
ArticleList articleListARS = ArticleList.fromJson(headlinesDataARS);
ArticleList articleListCNBC = ArticleList.fromJson(headlinesDataCNBC);
ArticleList articleListALJ = ArticleList.fromJson(headlinesDataALJ);
ArticleList articleListENG = ArticleList.fromJson(headlinesDataENG);
ArticleList articleListBND = ArticleList.fromJson(headlinesDataBND);

class _NewsListPageState extends State<NewsListPage>
    with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  Future<Null> updatingNewsList() async {
    await Future.delayed(Duration(seconds: 2));
    NetworkHelper BBC_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper ARS_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=ars-technica&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper CNBC_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=cnbc&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper ALJ_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=al-jazeera-english&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper ENG_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=engadget&apiKey=d73aacc5bf514debb3377163552e3d98');
    NetworkHelper BND_helper = NetworkHelper(
        'https://newsapi.org/v2/top-headlines?sources=business-insider&apiKey=d73aacc5bf514debb3377163552e3d98');
    headlinesDataBBC = await BBC_helper.getTopHeadlines();
    headlinesDataARS = await ARS_helper.getTopHeadlines();
    headlinesDataCNBC = await CNBC_helper.getTopHeadlines();
    headlinesDataALJ = await ALJ_helper.getTopHeadlines();
    headlinesDataENG = await ENG_helper.getTopHeadlines();
    headlinesDataBND = await BND_helper.getTopHeadlines();
    setState(() {});
    print('updating news...');
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              labelPadding: EdgeInsets.fromLTRB(7, 0, 7, 12),
              isScrollable: true,
              indicatorColor: Colors.black45,
              tabs: <Widget>[
                Text('BBC',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
                Text('Ars Technica',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
                Text('CNBC',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
                Text('Al Jazeera',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
                Text('Engadget',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
                Text('Business Insider',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w300)),
              ],
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(icon: Icon(Icons.menu)),
            title: Text(
              'MVR Times',
              style: TextStyle(
                  fontSize: 32, color: Colors.black, fontFamily: 'OldLondon'),
            ),
          ),
          body: TabBarView(children: [
            NewsListContainer(articleListBBC),
            NewsListContainer(articleListARS),
            NewsListContainer(articleListCNBC),
            NewsListContainer(articleListALJ),
            NewsListContainer(articleListENG),
            NewsListContainer(articleListBND),
          ])),
    );
  }

  Container NewsListContainer(ArticleList sourceArticleList) {

    return Container(
            child: RefreshIndicator(
              onRefresh: updatingNewsList,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: sourceArticleList.totalResults,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var article = sourceArticleList.articles[index];
                  dynamic timeDifference;
                  try{
                    timeDifference = DateTime.now().difference(DateTime.parse(article.publishedAt)).inHours;
                  }on FormatException catch(e){
                    print('error caught: $e');
                    timeDifference = 'few ';
                  }
                  return GestureDetector(
                    onTap: () {
//                _launchURL(url) async {
//
//                  if (await canLaunch(url)) {
//                    await launch(url,forceWebView: true);
//                  } else {
//                    throw 'Could not launch ${url}';
//                  }
//                }
//                _launchURL(article.url);
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailsPage(article)));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(article.title ?? 'MISSING',
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(article.description,
                                      maxLines: 4,
                                      style: TextStyle(
                                        fontFamily: 'Noto',
                                        fontSize: 15,
                                      )),
                                ),
                                SizedBox(width: 5,),
                                Expanded(
                                  flex: 1,
                                  child: Hero(
                                    createRectTween: (Rect r1, Rect r2) =>
                                        RectTween(begin: r1, end: r2),
                                    tag: article.urlToImage,
                                    child: Image(
                                      fit: BoxFit.fitHeight,
                                      image: NetworkImage(
                                              article.urlToImage) ??
                                          AssetImage(
                                              'assets/image-placeholder.jpg'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        '${article.source.name}     $timeDifference hours ago',
                                        style: TextStyle(color: Colors.grey)),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      IconButton(icon: Icon(Icons.share),onPressed: (){
                                        Share.share('${article.title} -- ${article.url}');
                                      },),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
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
    dynamic timeDifference;
    try{
      timeDifference = DateTime.now().difference(DateTime.parse(widget.article.publishedAt)).inHours;
    }on FormatException catch(e){
      print('error caught: $e');
      timeDifference = 'few ';
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.article.source.name,
          style:
              TextStyle(color: Colors.grey, fontSize: 25, fontFamily: 'Noto'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share),onPressed: (){
            Share.share('${widget.article.title} -- ${widget.article.url}');
          },),
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
                      fontSize: 35,
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
            ),
//            description
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(widget.article.description,
                  style: TextStyle(fontSize: 20, fontFamily: 'Noto')),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) =>
                                ImageScreen(widget.article.urlToImage)));
                  },
                  child: Hero(
                    tag: widget.article.urlToImage,
                    child: Image(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(widget.article.urlToImage),
                    ),
                  ),
                )),
//            image caption
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.article.description.split('.')[0],
                style: TextStyle(color: Colors.grey, fontFamily: 'Noto'),
              ),
            ),
//            source name
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Text("By ${widget.article.source.name}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Text(
                  "${timeDifference} hours ago",
                  style: TextStyle(
                      color: Colors.red, fontFamily: 'Noto', fontSize: 18)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Text("${widget.article.content.split('.')[0]} .",
                  style: TextStyle(
                      fontSize: 20, color: Colors.black, fontFamily: 'Noto')),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: FlatButton(
                color: Colors.blueGrey,
                child: Text("Read More",
                    style: TextStyle(
                        fontSize: 20, color: Colors.white, fontFamily: 'Noto')),
                onPressed: (){
                  launch(widget.article.url);
                },
              ),
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
