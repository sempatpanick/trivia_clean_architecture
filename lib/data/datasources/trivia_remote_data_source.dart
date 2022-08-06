import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trivia_clean_architecture/common/exception.dart';

import '../models/number_trivia_model.dart';

abstract class TriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class TriviaRemoteDataSourceImpl implements TriviaRemoteDataSource {
  static const BASE_URL = 'http://numbersapi.com';

  final http.Client client;

  TriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final response = await client.get(Uri.parse('$BASE_URL/$number/trivia?json'));

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final response = await client.get(Uri.parse('$BASE_URL/random/trivia?json'));

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
