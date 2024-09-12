import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_testing/article.dart';

class NewsService {
  final _articels = List.generate(
    10,
    (index) => Article(
      title: lorem(paragraphs: 1, words: 3),
      content: lorem(
        paragraphs: 3,
        words: 500,
      ),
    ),
  );

  Future<List<Article>> getArticls() async {
    await Future.delayed(const Duration(seconds: 1));
    return _articels;
  }
}
