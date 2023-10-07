import 'package:flutt_folio/src/classes/flutt_folio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralSettingsTab extends StatelessWidget {
  GeneralSettingsTab({Key? key}) : super(key: key);

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    final fluttFolio = Provider.of<FluttFolio>(context);
    final TextEditingController titleController =
        TextEditingController(text: fluttFolio.settings["title"]);

    return Expanded(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onChanged: (value) {
                if (value.isEmpty) {
                  value = "FluttFolio";
                }
                fluttFolio.jsonSettings["title"] = value;
              },
              decoration: const InputDecoration(
                labelText: "Website Title",
                hintText: "FluttFolio",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Layout Editing Mode"),
                Switch(
                  thumbIcon: thumbIcon,
                  value: fluttFolio.settings["isEditMode"],
                  onChanged: (bool value) {
                    fluttFolio.jsonSettings["isEditMode"] = value;
                    fluttFolio.notify();
                  },
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
