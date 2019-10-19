import 'dart:convert';
import 'package:http/http.dart';

class NetworkHelper{
  String url;
  NetworkHelper(this.url);

  Future<Map> getTopHeadlines() async{
    Map decodedData;
    Response response = await get(url);
    if(response.statusCode==200){
      decodedData = jsonDecode(response.body);
    }
    return decodedData;
  }
}