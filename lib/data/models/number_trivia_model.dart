import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:trivia_clean_architecture/domain/entities/number_trivia.dart';

part 'number_trivia_model.g.dart';

@JsonSerializable()
class NumberTriviaModel extends Equatable {
  final int number;
  final String text;

  const NumberTriviaModel({required this.number, required this.text});

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NumberTriviaModelToJson(this);

  NumberTrivia toEntity() {
    return NumberTrivia(number: number, text: text);
  }

  @override
  List<Object?> get props => [number, text];
}
