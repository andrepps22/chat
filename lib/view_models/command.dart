import 'package:flutter/foundation.dart';

class Command<T> extends ChangeNotifier {
  Command(this._action);

  final Future<T> Function() _action;

  T? _data;
  T? get data => _data;

  bool _isExecuting = false;
  bool get isExecuting => _isExecuting;

  Future<void> execute() async {
    if(_isExecuting) return;

    _isExecuting = true;
    notifyListeners();

    try {
      _data = await _action();
    } finally {
      _isExecuting = false;
      notifyListeners();
    }
  }
}
