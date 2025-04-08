import 'dart:convert'; // JSON işlemleri için gerekli
import 'package:diary_mobile/core/utils/local_services/service/i_local_service.dart';
import 'package:diary_mobile/core/utils/local_services/utils/enum/local_keys.dart';
import 'package:diary_mobile/core/utils/local_services/utils/param/local_key_param.dart';
import 'package:diary_mobile/core/utils/local_services/utils/param/local_key_with_value_param.dart';
import 'package:flutter/material.dart';
import 'package:diary_mobile/feature/home/model/memory_model.dart';
import 'package:get_it/get_it.dart';

class HomeProvider with ChangeNotifier {
  final List<MemoryModel> _memories = [];
  final ILocalService _localService = GetIt.I<ILocalService>();

  List<MemoryModel> get memories => _memories;

  void addMemory(MemoryModel memory) {
    _memories.add(memory);
    _saveMemories();
    notifyListeners();
  }

  void removeMemory(int index) {
    _memories.removeAt(index);
    _saveMemories();
    notifyListeners();
  }

  Future<void> _saveMemories() async {
    try {
      final memoryJsonList = _memories.map((memory) => memory.toJson()).toList();
      final jsonString = jsonEncode(memoryJsonList);
      await _localService.saveDataFromKey(LocalKeyWithValueParam(key: LocalKeys.memories, value: jsonString));
    } catch (e) {
      // Hata yönetimi
    }
  }

  Future<void> loadMemories() async {
    try {
      final getDataFromKeyEither = await _localService.getDataFromKey(LocalKeyParam(key: LocalKeys.memories));
      getDataFromKeyEither.fold((failure) {
        _memories.clear();
        notifyListeners();
      }, (data) {
        final memoryJsonList = jsonDecode(data) as List<dynamic>;
        _memories.clear();
        _memories.addAll(memoryJsonList.map((json) => MemoryModel.fromJson(json as Map<String, dynamic>)).toList());
        notifyListeners();
      });
    } catch (e) {
      // Hata yönetimi
    }
  }
}
