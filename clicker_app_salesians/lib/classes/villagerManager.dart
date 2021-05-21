import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clicker_app_salesians/classes/shopItem.dart';
import 'package:clicker_app_salesians/classes/villager.dart';
import 'package:clicker_app_salesians/classes/typeColors.dart';

class VillagerManager {
  static SharedPreferences prefs;
  static int coins;
  static int progress;
  static int prestige;
  static bool completed;
  static List<int> foundVillagers;
  static int _savedCoins;
  static int _savedProgress;
  static int _savedPrestige;
  static bool _savedCompleted;
  static List<int> _savedFoundVillagers;

  static List<Villager> villagerdex = List<Villager>();

  static final List<shoppingItems> itemsOnShop = [
    shoppingItems(
      name: 'Flimsy Net',
      colors: [Colors.white, Colors.green[800]],
      asset: 'assets/shop/ToolNet.png',
      number_of_villagers: 1,
      cost: 5,
    ),
    shoppingItems(
      name: 'Net',
      colors: [Colors.white, Colors.green[800]],
      asset: 'assets/shop/ToolNetNormal.png',
      number_of_villagers: 3,
      cost: 12,
    ),
    shoppingItems(
      name: 'Golden Net',
      colors: [Colors.white, Colors.green[800]],
      asset: 'assets/shop/ToolNetGold.png',
      number_of_villagers: 5,
      cost: 25,
    ),
    shoppingItems(
      name: 'Nook Ticket',
      colors: [Colors.white, Colors.green[800]],
      asset: 'assets/shop/PlaneTicket.png',
      number_of_villagers: 7,
      cost: 35,
    ),    shoppingItems(
      name: 'Gold Nugget',
      colors: [Colors.white, Colors.green[800]],
      asset: 'assets/shop/Gold_Ore.png',
      number_of_villagers: 10,
      cost: 50,
    ),    shoppingItems(
      name: 'Gift Bag',
      colors: [Colors.white, Colors.green[800]],
      asset: 'assets/shop/WBagGold.png',
      number_of_villagers: 15,
      cost: 75,
    )
  ];

  static final Map<String, TypeColors> villagerPersonalityTypeColor = {
    'Jock': TypeColors(
      light: Color(0xFFC6D16E),
      normal: Color(0xFFA8B820),
      dark: Color(0xFF6D7815),
    ),
    'Uchi': TypeColors(
      light: Color(0xFF9DB7F5),
      normal: Color(0xFF6890F0),
      dark: Color(0xFF445E9C),
    ),
    'Cranky': TypeColors(
      light: Color(0xFFA27DFA),
      normal: Color(0xFF7038F8),
      dark: Color(0xFF4924A1),
    ),
    'Normal': TypeColors(
      light: Color(0xFFFAE078),
      normal: Color(0xFFF8D030),
      dark: Color(0xFFA1871F),
    ),
    'Lazy': TypeColors(
      light: Color(0xFFFA92B2),
      normal: Color(0xFFF85888),
      dark: Color(0xFFA13959),
    ),
    'Peppy': TypeColors(
      light: Color(0xFFD67873),
      normal: Color(0xFFC03028),
      dark: Color(0xFF7D1F1A),
    ),
    'Smug': TypeColors(
      light: Color(0xFFF5AC78),
      normal: Color(0xFFF08030),
      dark: Color(0xFF9C531F),
    ),
    'Snooty': TypeColors(
      light: Color(0xFFC6B7F5),
      normal: Color(0xFFA890F0),
      dark: Color(0xFF6D5E9C),
    )
  };

  VillagerManager();

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
    foundVillagers = List<int>();
    _readCoins();
    _readProgress();
    _readPrestige();
    _readCompleted();
    _readFoundVillagers();
  }

  static Future<void> loadVillagerdex(BuildContext context) async {
    String encodedData =
        await DefaultAssetBundle.of(context).loadString("assets/newvillagerslist.json");
    List<dynamic> decodedJson = jsonDecode(encodedData);

    VillagerManager.villagerdex.clear();

    decodedJson.forEach((item) {
      Villager villager = Villager.fromJson(item);
      VillagerManager.villagerdex.add(villager);
    });
  }

  static bool readTheme() {
    return prefs.getBool('isDark') ?? false;
  }

  static void writeTheme(bool isDark) async {
    await prefs.setBool('isDark', isDark);
  }

  static void _readCoins() {
    coins = prefs.getInt('coins') ?? 0;
  }

  static void _writeCoins() async {
    await prefs.setInt('coins', coins);
  }

  static void _readProgress() {
    progress = prefs.getInt('progress') ?? 0;
  }

  static void _writeProgress() async {
    await prefs.setInt('progress', progress);
  }

  static void _readFoundVillagers() {
    List<String> aux = prefs.getStringList('foundVillagers') ?? List<String>();
    aux.forEach((item) {
      foundVillagers.add(int.parse(item));
    });
  }

  static void _readPrestige() {
    prestige = prefs.getInt('prestige') ?? 0;
  }

  static void _writePrestige() async {
    await prefs.setInt('prestige', prestige);
  }

  static void _readCompleted() {
    completed = prefs.getBool('completed') ?? false;
  }

  static void _writeCompleted() async {
    await prefs.setBool('completed', completed);
  }

  static void _writeCaughtVillagers() async {
    List<String> aux = List<String>();
    foundVillagers.forEach((item) {
      aux.add(item.toString());
    });
    await prefs.setStringList('caughtVillagers', aux);
  }

  static bool spendCoins(int amount) {
    if (amount > coins) {
      return false;
    } else {
      coins -= amount;
      _writeCoins();
      return true;
    }
  }

  static void addCoins(int amount) {
    coins += amount;
    _writeCoins();
  }

  static void incrementProgress() {
    int power = 100 + (prestige * 5) + (foundVillagers.length / 10).floor();
    progress += power;
    if (progress >= 10) {
      addCoins(1);
      progress %= 100;
    }
    _writeProgress();
  }

  static void addVillager(int index) {
    foundVillagers.add(index);
    _writeCaughtVillagers();
  }

  static void saveValues() {
    _savedCoins = coins;
    _savedProgress = progress;
    _savedPrestige = prestige;
    _savedCompleted = completed;
    _savedFoundVillagers = foundVillagers;
  }

  static void restoreValues() {
    coins = _savedCoins;
    progress = _savedProgress;
    prestige = _savedPrestige;
    completed = _savedCompleted;
    foundVillagers = _savedFoundVillagers;

    _writeCoins();
    _writeProgress();
    _writePrestige();
    _writeCompleted();
    _writeCaughtVillagers();
  }

  static void resetValues() {
    coins = 0;
    progress = 0;
    prestige = 0;
    completed = false;
    foundVillagers = List<int>();
    _writeCoins();
    _writeProgress();
    _writePrestige();
    _writeCompleted();
    _writeCaughtVillagers();
  }

  static void completedVillagersList() {
    completed = true;
    _writeCompleted();
  }

  static void lvlUpPrestige() {
    _savedPrestige = prestige;
    resetValues();
    prestige = ++_savedPrestige;
    _writePrestige();
  }

  static int getPower() =>
      10 + (prestige * 5) + (foundVillagers.length / 10).floor();

  static int getRawPower() => 10 + (foundVillagers.length / 10).floor();
}
