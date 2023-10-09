import 'dart:convert';

// const values for widget selector
const String widgetSelectorClickEvent = "open://WidgetSelector";
const String widgetSelectorJson = '''
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

Map<String, dynamic> fillNullChildWithEditorWidgets(
    Map<String, dynamic> jsonMap) {
  // add the widget selector to all null children
  jsonMap = addWidgetSelectorToAllNullChildObjects(jsonMap);
  return jsonMap;
}

/// This function is used to get the final layout map with all Editor specific
/// widgets removed.
Map<String, dynamic> getFinalLayoutMap(Map<String, dynamic> inputMap) {
  // Remove all null children with widget selector
  inputMap = removeNullChildWithWidgetSelector(inputMap);
  // TODO: Remove all EditorStack Widgets (Editor Stack houses 2 btns edit/remove for each widget)
  return inputMap;
}

/// This function will add the widget selector to all null children and child's.
Map<String, dynamic> addWidgetSelectorToAllNullChildObjects(
    Map<String, dynamic> jsonMap) {
  int widgetCounter = 0;

  Map<String, dynamic> deepCopy(Map<String, dynamic> source) {
    // Serialize and deserialize the map to create a deep copy
    return json.decode(json.encode(source));
  }

  void traverse(dynamic node) {
    if (node is Map<String, dynamic>) {
      if (node.containsKey("children") && node["children"] is List) {
        widgetCounter++;
        Map<String, dynamic> widgetSelectorJsonMap =
            deepCopy(json.decode(widgetSelectorJson));
        widgetSelectorJsonMap["click_event"] =
            "$widgetSelectorClickEvent-$widgetCounter";
        node["children"].add(widgetSelectorJsonMap);
      } else if (node.containsKey("child") && node["child"] == null) {
        widgetCounter++;
        Map<String, dynamic> widgetSelectorJsonMap =
            deepCopy(json.decode(widgetSelectorJson));
        widgetSelectorJsonMap["click_event"] =
            "$widgetSelectorClickEvent-$widgetCounter";
        node["child"] = widgetSelectorJsonMap;
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

  Map<String, dynamic> copy = deepCopy(jsonMap);
  traverse(copy);
  return copy;
}

/// This function will remove all WidgetSelector from the layout map.
Map<String, dynamic> removeNullChildWithWidgetSelector(
    Map<String, dynamic> jsonMap) {
  print(jsonMap);
  dynamic filterObjects(dynamic obj) {
    if (obj is List) {
      obj = obj
          .map((item) => filterObjects(item))
          .where((item) => item != null)
          .toList();
    } else if (obj is Map<String, dynamic>) {
      if (obj.containsKey("click_event") &&
          obj["click_event"].contains(widgetSelectorClickEvent)) {
        return null; // Remove the object
      }

      Map<String, dynamic> mutableObj = Map.from(obj); // Create a mutable copy

      mutableObj.forEach((key, value) {
        mutableObj[key] = filterObjects(value);
      });

      return mutableObj; // Return the modified copy
    }
    return obj;
  }

  Map<String, dynamic> result = Map.from(jsonMap);

  result = filterObjects(result);
  return result;
}

/// This function will replace the widget selector with the click_event equal to
/// the given click_event with the given widget.
Map<String, dynamic> replaceWidgetSelectorWithWidget(
    Map<String, dynamic> jsonMap,
    String clickEvent,
    Map<String, dynamic> widget) {
  dynamic replaceObjects(dynamic obj) {
    if (obj is List) {
      obj = obj
          .map((item) => replaceObjects(item))
          .where((item) => item != null)
          .toList();
    } else if (obj is Map<String, dynamic>) {
      if (obj.containsKey("click_event") && obj["click_event"] == clickEvent) {
        return widget; // Replace the object
      }

      Map<String, dynamic> mutableObj = Map.from(obj); // Create a mutable copy

      mutableObj.forEach((key, value) {
        mutableObj[key] = replaceObjects(value);
      });

      return mutableObj; // Return the modified copy
    }
    return obj;
  }

  Map<String, dynamic> result = Map.from(jsonMap);

  result = replaceObjects(result);
  return result;
}
