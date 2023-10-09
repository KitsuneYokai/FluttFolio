import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutt_folio/src/app.dart';
import 'package:flutt_folio/src/widgets/selector/selectable_widgets_view.dart';
import 'package:flutt_folio/src/helper/layout.dart';

import 'package:flutt_folio/main.dart';

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
  Map<String, dynamic>? selectedWidget = await showSelectableWidgetsView(
      navigatorKey.currentState!.context, jsonIndex);

  if (selectedWidget != null) {
    Map<String, dynamic> addedJsonWidgetLayout =
        replaceWidgetSelectorWithWidget(fluttFolioClass.jsonLayout,
            "open://WidgetSelector-$jsonIndex", selectedWidget);
    Map<String, dynamic> addedWidgetSelectorJson =
        addWidgetSelectorToAllNullChildObjects(addedJsonWidgetLayout);
    fluttFolioClass.jsonLayout = addedWidgetSelectorJson;
  }
}
