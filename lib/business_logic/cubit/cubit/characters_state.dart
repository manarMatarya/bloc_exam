part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharacterLoadded extends CharactersState {
  final List<Character> characters;

  CharacterLoadded(this.characters);
}

class QuoteLoadded extends CharactersState {
  final List<Qoute> quotes;

  QuoteLoadded(this.quotes);
}
