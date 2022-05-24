// ignore_for_file: use_key_in_widget_constructors


import 'package:flutter/material.dart';

import '../screens/deployment_page.dart';
import '../screens/litter_marking.dart';
import '../screens/maps_page.dart';
import '../screens/noise_test.dart';
import '../screens/reports.dart';
import '../screens/schedule_page.dart';


class NavigationDrawerWidget extends StatelessWidget {
  final paddding = const EdgeInsets.symmetric(horizontal: 20);
  @override



  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Rally Schedule',
              icon: Icons.schedule,
              onClicked: () =>selectedItem(context, 0),
            ),

            const SizedBox(height: 24),
            const Divider(color: Colors.white),

            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Stage Maps',
              icon: Icons.map,
              onClicked: () =>selectedItem(context, 1),
            ),

            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Mark litter areas',
              icon: Icons.recycling,
              onClicked: () =>selectedItem(context, 2),
            ),

            const SizedBox(height: 24),
            const Divider(color: Colors.white),

            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Deployment Confirmation',
              icon: Icons.category,
              onClicked: () =>selectedItem(context, 3),
            ),

            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Noise Test Form',
              icon: Icons.graphic_eq,
              onClicked: () =>selectedItem(context, 4),
            ),

            const SizedBox(height: 24),
            const Divider(color: Colors.white),

            const SizedBox(height: 10),
            buildMenuItem(
              text: 'Reports',
              icon: Icons.summarize,
              onClicked: () =>selectedItem(context, 5),
            ),




          ],
        ),
      )
    );
  }

  Widget buildMenuItem({
     required String text,
     required IconData icon,
     VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SchedulePage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MapsPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LitterMapsPage(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const DeploymentConfirmationPage(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const NoisePage(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ReportsPage(),
        ));
        break;
    }
  }
}