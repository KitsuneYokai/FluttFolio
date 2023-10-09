import 'package:flutt_folio/src/widgets/selector/selectable_widgets.dart';
import 'package:flutt_folio/src/widgets/selector/widget_card.dart';
import 'package:flutt_folio/src/widgets/selector/widget_factory_view.dart';
import 'package:flutter/material.dart';

class SelectableWidgetsView extends StatelessWidget {
  final int jsonIndexReplacementNumber;

  const SelectableWidgetsView(
      {Key? key, required this.jsonIndexReplacementNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton.extended(
            heroTag: "factory",
            onPressed: () {
              showWidgetFactoryView(context);
            },
            label: const Text("Factory"),
            icon: const Icon(Icons.add)),
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(("Widget Selector $jsonIndexReplacementNumber"),
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
                // showcase widgets
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.spaceEvenly,
                      children: [
                        for (var widget in selectableWidgets) ...[
                          WidgetCard(
                              name: widget["name"],
                              description: widget["description"],
                              icon: widget["icon"],
                              jsonWidget: widget["jsonWidget"]),
                        ]
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}

Future<Map<String, dynamic>?> showSelectableWidgetsView(
    BuildContext context, int jsonReplacementIndexNumber) async {
  return await showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return SelectableWidgetsView(
        jsonIndexReplacementNumber: jsonReplacementIndexNumber,
      );
    },
  );
}
