import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/characters.dart';
import '../../data/repository/characters_repository.dart';
import 'movie_state.dart';


class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
   List<Character>characters=[];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character>getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;
  }
}
