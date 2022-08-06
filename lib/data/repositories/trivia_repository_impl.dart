import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:trivia_clean_architecture/common/exception.dart';
import 'package:trivia_clean_architecture/common/failure.dart';
import 'package:trivia_clean_architecture/data/datasources/trivia_local_data_source.dart';
import 'package:trivia_clean_architecture/data/datasources/trivia_remote_data_source.dart';
import 'package:trivia_clean_architecture/domain/entities/number_trivia.dart';
import 'package:trivia_clean_architecture/domain/repositories/trivia_repository.dart';

class TriviaRepositoryImpl implements TriviaRepository {
  final TriviaRemoteDataSource remoteDataSource;
  final TriviaLocalDataSource localDataSource;

  TriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    try {
      final result = await remoteDataSource.getConcreteNumberTrivia(number);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    try {
      final result = await remoteDataSource.getRandomNumberTrivia();

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
