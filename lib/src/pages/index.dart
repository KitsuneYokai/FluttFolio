import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutt_folio/src/pages/editor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String? event) {
    // here click events are handled
  }
}

/// Displays a list of SampleItems.
class IndexView extends StatelessWidget {
  const IndexView({
    super.key,
  });

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    // here all the logic for the view

    Future<Widget> buildIndex() async {
      String layoutString =
          await DefaultAssetBundle.of(context).loadString("assets/layout.json");
      // ignore: use_build_context_synchronously
      return DynamicWidgetBuilder.build(
          layoutString, context, DefaultClickListener())!;
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              onPressed: () {
                // here I will let the user change some settings that i cant
                // implement in the widget editor, like the background color
                // global text color/styles, Favicon or the page title.

                // I think you know by now what i mean by this 😉
              },
              child: const Icon(Icons.settings),
            )
          : null,
      body: kDebugMode
          ? const EditorView()
          : FutureBuilder<Widget>(
              future: buildIndex(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return snapshot.hasData
                    ? SizedBox.expand(
                        child: snapshot.data,
                      )
                    : const Text("Loading...");
              },
            ),
    );
  }
}
