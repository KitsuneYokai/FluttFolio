import 'package:flutt_folio/src/classes/flutt_folio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final fluttFolio = Provider.of<FluttFolio>(context);
    return Material(
      child: Row(
        children: [
          NavigationRail(
            elevation: 10,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            selectedIndex: _selectedIndex,
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.category),
                selectedIcon: Icon(Icons.category),
                label: Text('General'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                selectedIcon: Icon(Icons.search),
                label: Text('SEO'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.color_lens),
                selectedIcon: Icon(Icons.color_lens),
                label: Text('Theme'),
              ),
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(("Settings"),
                        style: Theme.of(context).textTheme.titleLarge),
                    const Spacer(),
                    IconButton(
                        splashRadius: 20,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close)),
                  ],
                ),
                const Divider(),
                Text(fluttFolio.settings["title"]),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

Future<bool?> showSettingsView(BuildContext context) async {
  return await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return const SettingsView();
    },
  );
}
