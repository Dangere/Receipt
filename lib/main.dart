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

    final bool onSplashScreen =
        ref.watch(onSplashScreenProvider); //refreshes once
    final SelectedLanguage selectedLang = ref.watch(selectedLanguageProvider);

    final List<Widget> tabs = [
      onSplashScreen ? const SplashScreen() : const StockTab(),
      const ReceiptsTab()
    ];

    Color darkAccent = const Color(0xff2E3039);

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.readexProTextTheme(),
        primarySwatch: MaterialColor(darkAccent.value, <int, Color>{
          50: darkAccent.withOpacity(0.1),
          100: darkAccent.withOpacity(0.2),
          200: darkAccent.withOpacity(0.3),
          300: darkAccent.withOpacity(0.4),
          400: darkAccent.withOpacity(0.5),
          500: darkAccent.withOpacity(0.6),
          600: darkAccent.withOpacity(0.7),
          700: darkAccent.withOpacity(0.8),
          800: darkAccent.withOpacity(0.9),
          900: darkAccent.withOpacity(1.0),
        }),
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.blue), // 2
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[350],
          body: Column(
            children: [
              if (!onSplashScreen) Header(pageController: pageController),
              Expanded(
                child: PageView(
                  onPageChanged: (value) => ref
                      .read(tabIndexProvider.notifier)
                      .update((state) => value),
                  //instead of using .state = value. I used update((state) => value)
                  controller: pageController,
                  children: tabs,
                ),
              ),
            ],
          ),
          drawerEnableOpenDragGesture: false,
          drawer: SideDrawer(
              selectedLang: selectedLang, pageController: pageController),
          floatingActionButton: Visibility(
            visible: !onSplashScreen,
            child: OpenPanelButton(),
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
              color: Colors.blueGrey[100],
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

class OpenPanelButton extends ConsumerWidget {
  const OpenPanelButton({super.key});

  // final bool slideUpPanelIsOpen;
  // final PanelController panelController;

  @override
  Widget build(BuildContext context, ref) {
    final int tabIndex = ref.watch(tabIndexProvider);
    final bool isPanelOpen = ref.watch(openPanelProvider);
    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: !isPanelOpen ? Offset.zero : const Offset(0, 2),
      child: Container(
        padding: const EdgeInsets.all(12) +
            const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 20, 16, 26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          onPressed: () {
            ref.read(freezeAppBarProvider.notifier).state = true;
            ref.read(openPanelProvider.notifier).state = true;
          },
          child: Text(
            tabIndex == 0 ? "Create Item" : "Create Receipt",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
        ),
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
