import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/Trie.dart';

void main() {
  test("test trie", () {
    bool exists = false;
    Trie trie = new Trie(list: ["a", "an"]);
    expect(exists, true);
    print(trie.toString());
  });
}