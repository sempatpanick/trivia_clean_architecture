import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/domain/entities/number_trivia.dart';

import '../../common/failure.dart';

abstract class TriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
