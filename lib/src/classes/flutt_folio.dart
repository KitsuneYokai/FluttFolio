import 'dart:convert';

import 'package:flutter/foundation.dart';

class FluttFolio with ChangeNotifier {
  // vars
  late Map<String, dynamic> layout;
  late Map<String, dynamic> settings;
  late bool isEditingMode;

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
    "click_event": "open://WidgetSelector",
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
      required this.settings});

  //getter
  Map<String, dynamic> get jsonLayout => _getJsonLayoutString();
  Map<String, dynamic> get jsonSettings => settings;

  // methods
  Map<String, dynamic> _getJsonLayoutString() {
    if (kDebugMode || isEditingMode) {
      return _fillNullChildWithWidgetSelector(layout);
    }
    return layout;
  }

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
          node["children"].add(json.decode(widgetSelectorJson));
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
}
