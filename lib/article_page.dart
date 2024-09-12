import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/news_states.dart';
import 'package:flutter_testing/newscubit.dart';

class ArticlePage extends StatelessWidget {
  final int index;
  const ArticlePage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, CubitStates>(
      builder: (context, state) {
        var c = NewsCubit.get(context);
        return Scaffold(
          body: Dismissible(
            key: const Key("1"),
            onDismissed: (DismissDirection direction) {
              Navigator.pop(context);
            },
            child: SafeArea(
                child: ListView(
              children: [
                Text(c.articles[index].content),
              ],
            )),
          ),
        );
      },
    );
  }
}
