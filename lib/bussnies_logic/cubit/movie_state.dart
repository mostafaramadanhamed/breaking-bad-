
import '../../data/models/characters.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class CharactersLoaded extends MovieState {
  final List<Character>characters;

  CharactersLoaded(this.characters);
}
