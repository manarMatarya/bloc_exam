import 'package:bloc/bloc.dart';
import '../../../data/models/Character.dart';
import '../../../data/models/qoutes.dart';
import '../../../data/repostery/character_repostery.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  List<Character> characters = [];
  late Qoute quotes;
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<Character> getAllCharacter() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharacterLoadded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuote({required String name}) {
    characterRepository.getCharactersQuote(name: name).then((quotes) {
      emit(QuoteLoadded(quotes));
    });
  }
}
