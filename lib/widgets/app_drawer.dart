import 'package:flutter/material.dart';

import '../screen/filters_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget buildListTitle(
      String title, IconData icon, void Function()? onTapLink) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Colors.blue,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'ElMessiri',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTapLink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'دليلك السياحي',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 20),
          buildListTitle(
            'الرحلات',
            Icons.card_travel,
            () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          buildListTitle(
            'الفلترة',
            Icons.filter_list,
            () {
              Navigator.of(context).pushNamed(FiltersScreen.screenRoute);
            },
          ),
          buildListTitle(
            'خروج',
            Icons.exit_to_app,
            () {
              Navigator.of(context).pushNamed('login-screen');
            },
          ),
        ],
      ),
    );
  }
}
