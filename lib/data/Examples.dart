import 'dart:io';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class Examples {
  static getExamples(String word){
    String url = "http://www.wordincontext.com/en/" + word;
    var client = new HttpClient();
    var req = await client.getUrl(Uri.parse(url));
    var res = await req.close();
    var len = res.length;
    var resBody = res.transform(utf8.decoder).join();
    var doc = parse(res);
    var html = doc.outerHtml;
    client.close();
  }
}