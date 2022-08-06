import 'package:flutter/material.dart';
import 'package:trivia_clean_architecture/common/state_enum.dart';
import 'package:trivia_clean_architecture/domain/entities/number_trivia.dart';
import 'package:trivia_clean_architecture/domain/usecases/get_concrete_number_trivia.dart';
import 'package:trivia_clean_architecture/domain/usecases/get_random_number_trivia.dart';

class NumberTriviaNotifier extends ChangeNotifier {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;

  NumberTriviaNotifier({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
  });

  late NumberTrivia _trivia;
  NumberTrivia get trivia => _trivia;

  RequestState _triviaState = RequestState.empty;
  RequestState get triviaState => _triviaState;

  String _message = '';
  String get message => _message;

  Future<void> fetchConcreteNumberTrivia(int number) async {
    _triviaState = RequestState.loading;
    notifyListeners();

    final result = await getConcreteNumberTrivia.execute(number: number);

    result.fold((failure) {
      _triviaState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (success) {
      _trivia = success;
      _triviaState = RequestState.loaded;
      notifyListeners();
    });
  }

  Future<void> fetchRandomNumberTrivia() async {
    _triviaState = RequestState.loading;
    notifyListeners();

    final result = await getRandomNumberTrivia.execute();

    result.fold((failure) {
      _triviaState = RequestState.error;
      _message = failure.message;
      notifyListeners();
    }, (success) {
      _trivia = success;
      _triviaState = RequestState.loaded;
      notifyListeners();
    });
  }
}
