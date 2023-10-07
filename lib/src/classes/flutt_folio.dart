import 'dart:convert';

import 'package:flutter/foundation.dart';

class FluttFolio with ChangeNotifier {
  // vars
  late Map<String, dynamic> layout;
  late Map<String, dynamic> settings;
  late bool isEditingMode;

  final String widgetSelectorClickEvent = "open://WidgetSelector";
  final String widgetSelectorJson = '''
  {
    "type": "ElevatedButton",
    "foregroundColor": null,
    "backgroundColor": null,
    "overlayColor": null,
    "shadowColor": null,
    "elevation": null,
    "padding": null,
    "textStyle": null,
    "click_event": null,
    "child": {
      "type": "Icon",
      "data": "add",
      "size": null,
      "color": null,
      "semanticLabel": null,
      "textDirection": null
    }
  }
  ''';

  // constructor
  FluttFolio(
      {required this.layout,
      required this.isEditingMode,
      required this.settings}) {
    if (kDebugMode || isEditingMode) {
      layout = _fillNullChildWithWidgetSelector(layout);
    }
  }

  //getter
  Map<String, dynamic> get jsonLayout => layout;
  Map<String, dynamic> get jsonSettings => settings;

  // setter
  set jsonLayout(Map<String, dynamic> newLayout) {
    layout = newLayout;
    notifyListeners();
  }

  set jsonSettings(Map<String, dynamic> newSettings) {
    settings = newSettings;
    notifyListeners();
  }

  // methods
  Map<String, dynamic> _fillNullChildWithWidgetSelector(
      Map<String, dynamic> jsonMap) {
    // add the widget selector to all null children
    jsonMap = _addWidgetToAllNullChild(jsonMap);
    // add the widget selector to all children
    jsonMap = _addWidgetToAllChildren(jsonMap);
    return jsonMap;
  }

  Map<String, dynamic> _addWidgetToAllChildren(Map<String, dynamic> jsonMap) {
    void traverse(dynamic node) {
      if (node is Map<String, dynamic>) {
        if (node.containsKey("children") && node["children"] is List) {
          // add a :<json index number> to the click event
          Map<String, dynamic> widgetSelectorJson =
              json.decode(this.widgetSelectorJson);
          widgetSelectorJson["click_event"] =
              "$widgetSelectorClickEvent-${node["children"].length + 1}";
          node["children"].add(widgetSelectorJson);
        }
        for (var key in node.keys) {
          traverse(node[key]);
        }
      } else if (node is List) {
        for (var item in node) {
          traverse(item);
        }
      }
    }

    traverse(jsonMap);
    return jsonMap;
  }

  Map<String, dynamic> _addWidgetToAllNullChild(Map<String, dynamic> jsonMap) {
    void traverse(dynamic node) {
      if (node is Map<String, dynamic>) {
        if (node.containsKey("child") && node["child"] == null) {
          node["child"] = json.decode(widgetSelectorJson);
        }
        for (var key in node.keys) {
          traverse(node[key]);
        }
      } else if (node is List) {
        for (var item in node) {
          traverse(item);
        }
      }
    }

    traverse(jsonMap);
    return jsonMap;
  }

  notify() {
    notifyListeners();
  }
}
