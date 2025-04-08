import 'package:flutter/material.dart';
import 'package:diary_mobile/feature/home/model/memory_model.dart';

class HomeProvider with ChangeNotifier {
  final List<MemoryModel> _memories = [];

  List<MemoryModel> get memories => _memories;

  void addMemory(MemoryModel memory) {
    _memories.add(memory);
    notifyListeners();
  }
}
