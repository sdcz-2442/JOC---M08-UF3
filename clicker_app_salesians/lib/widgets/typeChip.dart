import 'package:flutter/material.dart';
import 'package:clicker_app_salesians/classes/villagerManager.dart';
import 'package:clicker_app_salesians/classes/typeColors.dart';

class TypeChip extends StatelessWidget {
  TypeChip({this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    TypeColors typeColor = VillagerManager.villagerPersonalityTypeColor[name];
    return Chip(
      label: Text(
        name,
        style: TextStyle(color: Colors.black54),
      ),
      elevation: 2.0,
      backgroundColor: typeColor.light,
    );
  }
}
