import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clicker_app_salesians/classes/villagerManager.dart';
import 'package:clicker_app_salesians/classes/themeChanger.dart';
import 'package:clicker_app_salesians/pages/about_me.dart';
import 'package:clicker_app_salesians/pages/clicker.dart';
import 'package:clicker_app_salesians/pages/allVillagersList.dart';
import 'package:clicker_app_salesians/pages/settings.dart';
import 'package:clicker_app_salesians/pages/shop.dart';
import 'package:clicker_app_salesians/pages/win.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await VillagerManager.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    VillagerManager.loadVillagerdex(context);

    return ChangeNotifierProvider<ThemeChanger>(
      create: (context) {
        return ThemeChanger(
          VillagerManager.readTheme()
              ? ThemeData.dark()
              : ThemeData(
                  primaryColor: Colors.white,
                ),
        );
      },
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Clicker',
      theme: theme.getTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => ClickerPage(),
        '/VillagersList': (context) => AllVillagersPage(),
        '/shop': (context) => ShopPage(),
        '/settings': (context) => SettingsPage(),
        '/about_me': (context) => AboutMePage(),
        '/win': (context) => WinPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
