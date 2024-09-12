import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_testing/news_page.dart';
import 'package:flutter_testing/newscubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Testing.',
      debugShowCheckedModeBanner: false,
      home: FlutterTesting(),
    );
  }
}

class FlutterTesting extends StatelessWidget {
  const FlutterTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getArticles(),
      child: const NewsPage(),
    );
  }
}
