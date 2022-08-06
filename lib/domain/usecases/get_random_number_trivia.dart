import 'package:dartz/dartz.dart';

import '../../common/failure.dart';
import '../entities/number_trivia.dart';
import '../repositories/trivia_repository.dart';

class GetRandomNumberTrivia {
  final TriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute() {
    return repository.getRandomNumberTrivia();
  }
}
