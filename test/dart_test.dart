/**
 * Created by Pulkit Singh on 3/6/2018.
 */

import 'dart:io';

import 'package:myapp/Trie.dart';

void main() {
  File file = new File("assets/words_list.txt");
  file.readAsLines().then((lines) {
    Trie trie = new Trie(list: lines);
    trie.suggestions("Speci",length: 3).forEach((suggestion) {
      print(suggestion);
    });
  });
}