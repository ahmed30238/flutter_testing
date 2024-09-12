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
  group(
    "get articles",
    () {
      var articlesFromService = [
        Article(title: "Test 1 Title", content: "Test 1 content"),
        Article(title: "Test 2 Title", content: "Test 2 content"),
        Article(title: "Test 3 Title", content: "Test 3 content"),
      ];
      void arrangeNewsServiceReturns3Articles() {
        when(() => mockNewsService.getArticls())
            .thenAnswer((_) async => articlesFromService);
      }

      test(
        "get articles using NewsServic",
        () async {
          when(() => mockNewsService.getArticls()).thenAnswer((_) async => []);
          await sut.getArticles();
          verify(
            () => mockNewsService.getArticls(),
          ).called(1);
        },
      );

      test(
        """indicates loading of data,
      sets articles to the ones from the service,
      indicates that data is not being loaded anymore""",
        () async {
          arrangeNewsServiceReturns3Articles();
          final future = sut.getArticles();
          expect(sut.isLoading, true);
          await future;
          expect(sut.articles, articlesFromService);
          expect(sut.isLoading, false);
        },
      );
    },
  );
}
