import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/header.dart';
import 'pages/items_record_page.dart';
import 'pages/splash_screen.dart';
import 'pages/stock_tab.dart';
import 'pages/receipts_tab.dart';
import 'providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController = PageController(initialPage: 0);
    final bool onSplashScreen = ref.watch(onSplashScreenProvider);

    final SelectedLanguage selectedLang = ref.watch(selectedLanguageProvider);

    final List<Widget> tabs = [
      onSplashScreen ? const SplashScreen() : const StockTab(),
      const ReceiptsTab()
    ];

    Future<bool> onWillPop() async {
      if (ref.read(openPanelProvider.notifier).state == true) {
        ref.read(openPanelProvider.notifier).state = false;
        ref.read(freezeAppBarProvider.notifier).state = false;
        FocusManager.instance.primaryFocus?.unfocus();

        return false;
      } else {
        return true;
      }
    }

    Color darkAccent = const Color(0xff2E3039);

    return MaterialApp(
      theme: ThemeData(
        // colorSchemeSeed: Color(0xFFFFBF9B),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blueGrey.shade800,
          onPrimary: Colors.blueGrey.shade50,
          secondary: Colors.blueGrey.shade100,
          onSecondary: Color(0xFF4D4D4D),
          error: Color(0xFFF32424),
          onError: Color(0xFF4D4D4D),
          background: Colors.grey.shade300,
          onBackground: Color(0xFF4D4D4D),
          surface: Color(0xFFFFFFFF),
          onSurface: Color(0xFF4D4D4D),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.readexProTextTheme(),
        scaffoldBackgroundColor: Colors.blueGrey.shade800,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: WillPopScope(
          onWillPop: onWillPop,
          child: Scaffold(
            body: Column(
              children: [
                if (!onSplashScreen) Header(pageController: pageController),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    child: PageView(
                      onPageChanged: (value) => ref
                          .read(tabIndexProvider.notifier)
                          .update((state) => value),
                      //instead of using .state = value. I used update((state) => value)
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: tabs,
                    ),
                  ),
                ),
              ],
            ),
            drawerEnableOpenDragGesture: false,
            drawer: SideDrawer(
                selectedLang: selectedLang, pageController: pageController),
            // floatingActionButton: Visibility(
            //   visible: !onSplashScreen,
            //   child: OpenPanelButton(),
            // ),
          ),
        ),
      ),
    );
  }
}

class SideDrawer extends ConsumerWidget {
  const SideDrawer({
    super.key,
    required this.selectedLang,
    required this.pageController,
  });

  final SelectedLanguage selectedLang;
  final PageController pageController;

  @override
  Widget build(BuildContext context, ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: const UserDrawer(),
          ),
          Builder(builder: (context) {
            return ListTile(
              leading: const Icon(Icons.data_array_rounded),
              title: Text(selectedLang == SelectedLanguage.arabic
                  ? 'سجل البضاعة'
                  : 'Items record'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecordPage()));
                Scaffold.of(context).closeDrawer();
              },
            );
          }),
          Builder(builder: (context) {
            return ListTile(
              leading: const Icon(Icons.add_to_home_screen_rounded),
              title: Text(selectedLang == SelectedLanguage.arabic
                  ? 'شاشة البداية'
                  : 'Splash Screen'),
              onTap: () {
                ref.read(onSplashScreenProvider.notifier).state = true;
                pageController.jumpToPage(0);
                Scaffold.of(context).closeDrawer();
              },
            );
          }),
        ],
      ),
    );
  }
}

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CircleAvatar(
        //   child: Image.asset("assets/images/PortraitPlaceholder.jpg"),
        // ),
        SizedBox(
            height: 80,
            width: 80,
            child: ClipOval(
                child: Image.asset("assets/images/PortraitPlaceholder.jpg"))),

        const SizedBox(
          height: 10,
        ),
        const Text(
          "User Name",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
