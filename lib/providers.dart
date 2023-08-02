import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
// import 'package:sliding_up_panel/sliding_up_panel.dart';

final slidePanelControllerProvider = StateProvider<PanelController>((ref) => PanelController());

final isSlideUpPanelOpenProvider = StateProvider<bool>((ref) => false);

final pageIndexProvider = StateProvider<int>((ref) => 0);

final freezeAppBarProvider = StateProvider<bool>((ref) => false);

final onSplashScreenProvider = StateProvider<bool>((ref) => true);

final selectedLanguageProvider = StateProvider<SelectedLanguage>((ref) => SelectedLanguage.english);

enum SelectedLanguage { arabic, english }

final displayLanguageOptionsProvider = StateProvider<bool>((ref) => false);
