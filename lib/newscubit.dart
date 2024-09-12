import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/article.dart';
import 'package:flutter_testing/news_service.dart';
import 'package:flutter_testing/news_states.dart';

class NewsCubit extends Cubit<CubitStates> {
  NewsCubit() : super(NewsInitState());

  static NewsCubit get(context) => BlocProvider.of(context);
  List<Article> _articles = [];
  List<Article> get articles => _articles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getArticles() async {
    _isLoading = true;
    emit(GetArticleLoaingState());
    _articles = await NewsService().getArticls();
    _isLoading = false;
    emit(GetArticleSuccessState());
    // todo
  }
}
