import 'dart:convert';

import 'package:flutt_folio/src/classes/flutt_folio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ExporterTabView extends StatelessWidget {
  final String type;
  const ExporterTabView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final TextEditingController jsonTextField = TextEditingController();
    // dynamically build the tab views based on the type
    if (type == "layout") {
      jsonTextField.text =
          jsonEncode(Provider.of<FluttFolio>(context).jsonLayout);
      // TODO: remove the buttons with click_event = open://WidgetSelector
    } else if (type == "settings") {
      jsonTextField.text =
          jsonEncode(Provider.of<FluttFolio>(context).settings);
    } else if (type == "theme") {
      jsonTextField.text = '{"error": "Not implemented yet"}';
    }

    // making the json more readable
    jsonTextField.text = const JsonEncoder.withIndent('  ')
        .convert(jsonDecode(jsonTextField.text));

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(type[0].toUpperCase() + type.substring(1),
            style: Theme.of(context).textTheme.titleLarge),
        Text("Save the following json to assets/$type.json"),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                maxLines: null,
                controller: jsonTextField,
                readOnly: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10),
                ),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              onPressed: () {
                // copy the json to clipboard
                Clipboard.setData(ClipboardData(text: jsonTextField.text));
              },
              child: Text("Copy to clipboard")),
        )
      ]),
    );
  }
}
