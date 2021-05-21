import 'package:flutter/material.dart';
import 'package:clicker_app_salesians/classes/villagerManager.dart';
import 'package:clicker_app_salesians/widgets/shopItem.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: RichText(text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: 'Shop ', style: TextStyle(fontFamily: "Pacifico", color: Colors.white, fontSize: 25)),
          ],
        ),
        ),
      ),
      body: ListView.builder(
        itemCount: VillagerManager.itemsOnShop.length,
        itemBuilder: (BuildContext context, int index) {
          return ShopItem(item: VillagerManager.itemsOnShop[index]);
        },
      ),
    );
  }
}
