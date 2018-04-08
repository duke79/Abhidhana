import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';

class Examples {
  static Future<List<String>> getExamples(String word) async {
    List<String> examples = new List();
    String url = "http://www.wordincontext.com/en/" + word;
    var res = await get(Uri.parse(url));
    var len = res.contentLength;
//      var resBody = res.transform(utf8.decoder).join();
    var doc = parse(res.body);
    var html = doc.outerHtml;
    var sentences = doc.querySelectorAll("#content .sentence");
    for (var sentence in sentences) {
      examples.add(sentence.text);
    }
    return examples;
  }
}