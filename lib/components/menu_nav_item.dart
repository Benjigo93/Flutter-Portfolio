import 'package:flutter/material.dart';

// Burger Menu
class MenuNavigationItem extends ListTile {
  const MenuNavigationItem({Key? key, required this.itemTitle, required this.itemLink }) : super(key: key);
  final String itemTitle;
  final String itemLink;

  @override
  ListTile build(BuildContext context) {
    return ListTile(
      title: Text(
        itemTitle,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 35.0, right: 35.0, top: 5.0, bottom: 5.0),
      textColor: Colors.blue,
      selectedColor: const Color.fromRGBO(21, 96, 189, 1.0),
      selectedTileColor: const Color.fromRGBO(115, 194, 251, 0.5),
      selected: ModalRoute.of(context)?.settings.name == itemLink,
      onTap: () {
        Navigator.pushNamed(context , itemLink);
      },
    );
  }
}