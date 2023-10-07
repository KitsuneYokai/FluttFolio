import 'package:flutt_folio/src/widgets/exporter/exporter_view.dart';
import 'package:flutt_folio/src/widgets/settings/general_tab.dart';
import 'package:flutt_folio/src/widgets/settings/seo_tab.dart';
import 'package:flutt_folio/src/widgets/settings/theme_tab.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => SettingsViewState();
}

class SettingsViewState extends State<SettingsView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                icon: Icon(Icons.category_outlined),
                selectedIcon: Icon(Icons.category),
                label: Text('General'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.search),
                selectedIcon: Icon(Icons.search),
                label: Text('SEO'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.color_lens_outlined),
                selectedIcon: Icon(Icons.color_lens),
                label: Text('Theme'),
              ),
              NavigationRailDestination(
                  icon: Icon(Icons.save_outlined),
                  selectedIcon: Icon(Icons.save),
                  label: Text('Exporter')),
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
                if (_selectedIndex == 0)
                  GeneralSettingsTab()
                else if (_selectedIndex == 1)
                  const SeoSettingsTab()
                else if (_selectedIndex == 2)
                  const ThemeSettingsTab()
                else if (_selectedIndex == 3)
                  const Expanded(
                      child: JsonExporter(
                    showCloseButton: false,
                  ))
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
