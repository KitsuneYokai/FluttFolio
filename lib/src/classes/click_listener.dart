import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutt_folio/src/app.dart';
import 'package:flutt_folio/src/widgets/selector/selectable_widgets_view.dart';

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String? event) async {
    // here click events are handled
    if (event == null) return;
    if (event.contains("open://WidgetSelector")) {
      var jsonIndex = int.parse(event.split("-")[1]);
      await widgetSelectorPush(jsonIndex);
    }
  }
}

Future widgetSelectorPush(jsonIndex) async {
  var test = await showSelectableWidgetsView(
      navigatorKey.currentState!.context, jsonIndex);
  // TODO: Create a reusable function to update the layout json file
  print(test);
}
