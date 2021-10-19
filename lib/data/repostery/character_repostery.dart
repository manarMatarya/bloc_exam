import '../models/Character.dart';
import '../models/qoutes.dart';
import '../web_service/character_web_services.dart';

class CharacterRepository {
  final CharacterWebServices characterWebServices;

  CharacterRepository(this.characterWebServices);
  Future<List<Character>> getAllCharacters() async {
    final characters = await characterWebServices.getAllCharacters();
    return characters.map((e) => Character.fromJson(e)).toList();
  }

  Future<List<Qoute>> getCharactersQuote({required String name}) async {
    final quotes = await characterWebServices.getCharactersQuote(name: name);
    return quotes.map((e) => Qoute.fromJson(e)).toList();
  }
}
