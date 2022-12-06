
import 'package:movie/data/models/qoute.dart';

import '../../data/models/characters.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character>characters;

  CharactersLoaded(this.characters);
}
class QuotesLoaded extends CharactersState {
  final List<Quote>quotes;

  QuotesLoaded(this.quotes);
}
