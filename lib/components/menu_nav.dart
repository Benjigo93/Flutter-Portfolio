import 'package:flutter/material.dart';

import 'menu_nav_item.dart';

// Burger Menu
class MenuNavigation extends Drawer {
  const MenuNavigation({Key? key}) : super(key: key);

  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
            margin: const EdgeInsets.only(bottom: 35.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Flexible(
                    child: Text(
                      'Benjamin Kichenamourty',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.white
                      ) ,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                    'Portfolio',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const MenuNavigationItem(itemTitle: 'Presentation', itemLink: '/', ),
          const MenuNavigationItem(itemTitle: 'Compétence', itemLink: '/competence', ),
          const MenuNavigationItem(itemTitle: 'Parcours', itemLink: '/parcours', ),
          const MenuNavigationItem(itemTitle: 'Entreprise', itemLink: '/entreprise', ),
          const MenuNavigationItem(itemTitle: 'Faq', itemLink: '/faq', ),
          const MenuNavigationItem(itemTitle: 'Pokédex', itemLink: '/pokedex', ),
          const MenuNavigationItem(itemTitle: 'Météo', itemLink: '/meteo', ),
          const MenuNavigationItem(itemTitle: 'Scanner', itemLink: '/scanner', ),
          const MenuNavigationItem(itemTitle: 'Contact', itemLink: '/contact', ),
        ],
      ),
    );
  }
}