import 'package:flutt_folio/src/helper/layout.dart';
import 'package:flutter/foundation.dart';

class FluttFolio with ChangeNotifier {
  // vars
  late Map<String, dynamic> _layout;
  late Map<String, dynamic> _settings;
  late bool _isEditingMode;

  //getter
  Map<String, dynamic> get jsonLayout => _layout;
  Map<String, dynamic> get jsonSettings => _settings;
  bool get isEditingMode => _isEditingMode;
  // setter
  set jsonLayout(Map<String, dynamic> newLayout) {
    _layout = newLayout;
    notifyListeners();
  }

  set jsonSettings(Map<String, dynamic> newSettings) {
    _settings = newSettings;
    notifyListeners();
  }

  // methods
  initialize(Map<String, dynamic> layout, Map<String, dynamic> settings,
      bool isEditingMode) {
    if (kDebugMode || isEditingMode) {
      layout = fillNullChildWithEditorWidgets(layout);
    }
    _layout = layout;
    _isEditingMode = isEditingMode;
    _settings = settings;
  }

  // function to manually
  notify() {
    notifyListeners();
  }
}
