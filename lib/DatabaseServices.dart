import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:myapp/Trie.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  static Database _db;
  static Future<Database> _dbFuture;
  static Future<Trie> _trieFuture;
  static int VERSION = 1;

  static Future<Database> get db {
    if (null == _dbFuture)
      _dbFuture = database();
    return _dbFuture;
  }

  static Future<Trie> get trie {
    if (null == _trieFuture)
      _trieFuture = _trie();
    return _trieFuture;
  }

  static Future<Trie> _trie() async {
    String data = await rootBundle.loadString(join("assets", "words_list.txt"));
    List words = data.split("\r\n");
    Trie trie = new Trie();
    for (String word in words) {
      trie.addWord(word);
    }
    return trie;
  }

  static Future<Database> database() async {
    if (null != _db) return _db;

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Dictionary.db");

    // open the database
    _db = await openDatabase(path);
    if (null != _db) {
      if (await _db.getVersion() == VERSION)
        return _db;
    }

    // delete existing if any
    await deleteDatabase(path);

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "Dictionary.db"));
    List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes, data.lengthInBytes);
    await new File(path).writeAsBytes(bytes);

    // open the database
    _db = await openDatabase(path);
    _db.setVersion(VERSION);
    return _db;
  }
}