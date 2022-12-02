
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/characters.dart';
import '../../data/repository/characters_repository.dart';
import 'movie_state.dart';


class MovieCubit extends Cubit<MovieState> {
  final CharactersRepository charactersRepository;
  late List<Character>characters;
  MovieCubit(this.charactersRepository) : super(MovieInitial());

  List<Character>getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;
  }
}
