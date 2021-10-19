import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/cubit/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/Character.dart';
import 'data/repostery/character_repostery.dart';
import 'data/web_service/character_web_services.dart';
import 'presentation/screens/characters_details.dart';
import 'presentation/screens/characters_screen.dart';

class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebServices());
    charactersCubit =
        CharactersCubit(CharacterRepository(CharacterWebServices()));
  }

  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case characterScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: const CharactersScreen(),
                ));
      case characterDetailsScreen:
        final character = setting.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharactersCubit(characterRepository),
                  child: CharactersDetails(
                    character: character,
                  ),
                ));
    }
  }
}
