import 'package:flutter_riverpod/flutter_riverpod.dart';

final openPanelProvider = StateProvider<bool>((ref) => false);

final tabIndexProvider = StateProvider<int>((ref) => 0);

final freezeAppBarProvider = StateProvider<bool>((ref) => false);

final onSplashScreenProvider = StateProvider<bool>((ref) => true);

final selectedLanguageProvider =
    StateProvider<SelectedLanguage>((ref) => SelectedLanguage.english);

enum SelectedLanguage { arabic, english }

final displayLanguageOptionsProvider = StateProvider<bool>((ref) => false);
