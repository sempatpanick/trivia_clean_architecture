import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_clean_architecture/injection.dart' as di;
import 'package:trivia_clean_architecture/presentation/pages/home_page.dart';
import 'package:trivia_clean_architecture/presentation/provider/number_trivia_notifier.dart';

void main() {
  runApp(const MyApp());
  di.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<NumberTriviaNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
