import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/common/failure.dart';
import 'package:trivia_clean_architecture/domain/entities/number_trivia.dart';
import 'package:trivia_clean_architecture/domain/repositories/trivia_repository.dart';

class GetConcreteNumberTrivia {
  final TriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({required int number}) {
    return repository.getConcreteNumberTrivia(number);
  }
}
