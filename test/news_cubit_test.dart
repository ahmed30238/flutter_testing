import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing/article.dart';
import 'package:flutter_testing/news_service.dart';
import 'package:flutter_testing/newscubit.dart';
import 'package:mocktail/mocktail.dart';

class BadMockNewsService implements NewsService {
  bool isLoading = true;
  @override
  Future<List<Article>> getArticls() async {
    isLoading = false;
    // must retun predictabl data
    return [
      Article(title: "Test 1 Title", content: "Test 1 content"),
      Article(title: "Test 2 Title", content: "Test 2 content"),
      Article(title: "Test 3 Title", content: "Test 3 content"),
    ];
  }
}

class MockNewsService extends Mock implements NewsService {}

void main() {
  late NewsCubit sut;
  late MockNewsService mockNewsService;

  setUp(() {
    mockNewsService = MockNewsService();
    sut = NewsCubit(mockNewsService);
  });

  test("init Valeus are correct", () {
    expect(sut.isLoading, false);
    expect(sut.articles, []);
  });

  group("get articles", () {
    test("getarticles", () async {
      when(() => mockNewsService.getArticls()).thenAnswer(
        (_) async => [],
      );
      await sut.getArticles();
      verify(() => mockNewsService.getArticls(),).called(1 );
    });
  });
}
