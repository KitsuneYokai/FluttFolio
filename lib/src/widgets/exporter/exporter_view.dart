import 'package:flutt_folio/src/widgets/exporter/exporter_tab_view.dart';
import 'package:flutter/material.dart';

class JsonExporter extends StatelessWidget {
  const JsonExporter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(("Json Exporter"),
                      style: Theme.of(context).textTheme.titleLarge),
                  const Spacer(),
                  IconButton(
                      splashRadius: 20,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const Divider(),
              const TabBar(tabs: [
                Tab(
                  // layout
                  icon: Icon(Icons.view_quilt_sharp),
                ),
                // settings
                Tab(
                  icon: Icon(Icons.settings_sharp),
                ),
                // theme
                Tab(
                  icon: Icon(Icons.palette_sharp),
                ),
              ]),
              const Expanded(
                child: TabBarView(children: [
                  // layout
                  ExporterTabView(type: "layout"),
                  // settings
                  ExporterTabView(type: "settings"),
                  // theme
                  ExporterTabView(type: "theme"),
                ]),
              )
            ],
          ),
        )));
  }
}

Future showJsonExporter(BuildContext context) async {
  return await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return const JsonExporter();
    },
  );
}
