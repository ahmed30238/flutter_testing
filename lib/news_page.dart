import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/article_page.dart';
import 'package:flutter_testing/news_states.dart';
import 'package:flutter_testing/newscubit.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, CubitStates>(
      builder: (context, state) {
        var c = NewsCubit.get(context);
        return c.isLoading
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                body: SafeArea(
                  child: ListView.separated(
                    itemBuilder: (context, index) => ArticleItem(
                      title: c.articles[index].title,
                      desc: c.articles[index].content,
                      index: index,
                      c: c,
                    ),
                    itemCount: c.articles.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class ArticleItem extends StatelessWidget {
  final String title;
  final String desc;
  final int index;
  final NewsCubit c;
  const ArticleItem(
      {super.key,
      required this.title,
      required this.desc,
      required this.index,
      required this.c});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: c,
              child: ArticlePage(
                index: index,
              ),
            ),
          )),
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  desc,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
