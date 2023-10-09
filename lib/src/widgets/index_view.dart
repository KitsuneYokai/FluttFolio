import 'dart:convert';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutt_folio/src/classes/click_listener.dart';
import 'package:flutt_folio/src/classes/flutt_folio.dart';
import 'package:flutt_folio/src/widgets/exporter/exporter_view.dart';
import 'package:flutt_folio/src/widgets/selector/selectable_widgets_view.dart';
import 'package:flutt_folio/src/widgets/settings/settings_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IndexView extends StatelessWidget {
  const IndexView({super.key});
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final fluttFolio = Provider.of<FluttFolio>(context);

    Future<Widget>? buildIndex() async {
      return DynamicWidgetBuilder.build(
          jsonEncode(fluttFolio.jsonLayout), context, DefaultClickListener())!;
    }

    return Title(
        title: fluttFolio.jsonSettings["title"] ?? "FluttFolio",
        color: Colors.white,
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: fluttFolio.isEditingMode || kDebugMode
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FloatingActionButton(
                      heroTag: "settings",
                      onPressed: () {
                        showSettingsView(context);
                      },
                      child: const Icon(Icons.settings),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton(
                      heroTag: "export",
                      onPressed: () {
                        showJsonExporter(context);
                      },
                      child: const Icon(Icons.save),
                    ),
                  ],
                )
              : null,
          body: FutureBuilder<Widget>(
            future: buildIndex(),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 50),
                    const Text(
                        "No Layout Found, you can create one by clicking the button below 👇"),
                    const Text(
                        "and save the layout as layout.json in the assets folder of your forked repository"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          showSelectableWidgetsView(context, -999);
                        },
                        child: const Icon(Icons.add)),
                  ],
                ));
              }
              if (snapshot.hasData) {
                return SizedBox(
                  width: double.infinity,
                  child: snapshot.data!,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}
