Map<String, dynamic> getFinalLayoutMap(Map<String, dynamic> inputMap) {
  // Remove all null children with widget selector
  inputMap = removeNullChildWithWidgetSelector(inputMap);
  return inputMap;
}

Map<String, dynamic> removeNullChildWithWidgetSelector(
    Map<String, dynamic> inputMap) {
  // remove from children
  if (inputMap.containsKey("children")) {
    List<dynamic> children = inputMap["children"];

    // Filter out ElevatedButton children with the specified click_event
    children = children.where((child) {
      if (child is Map<String, dynamic> && child["type"] == "ElevatedButton") {
        String clickEvent = child["click_event"];
        return !clickEvent.contains("open://WidgetSelector");
      }
      return true;
    }).toList();

    // Replace the "children" property with the filtered list
    inputMap["children"] = children;
  }

  // set child null if it is a widget selector
  if (inputMap.containsKey("child") &&
      inputMap["child"] is Map<String, dynamic>) {
    Map<String, dynamic> child = inputMap["child"];
    if (child.containsKey("type") &&
        child["type"] == "ElevatedButton" &&
        child["click_event"].contains("open://WidgetSelector")) {
      inputMap["child"] = null;
    }
  }

  return inputMap;
}
