import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_model.freezed.dart';
part 'memory_model.g.dart';

@freezed
class MemoryModel with _$MemoryModel {
  const factory MemoryModel({
    required String id,
    required List<String> imagePaths,
    required String message,
    required DateTime date,
  }) = _MemoryModel;

  factory MemoryModel.fromJson(Map<String, dynamic> json) => _$MemoryModelFromJson(json);
}
