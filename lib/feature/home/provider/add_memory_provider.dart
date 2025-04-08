import 'dart:io';
import 'package:diary_mobile/core/init/injection_container.dart';
import 'package:diary_mobile/core/utils/route_manager.dart';
import 'package:diary_mobile/feature/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:diary_mobile/core/utils/image/i_image_service.dart';
import 'package:diary_mobile/feature/home/model/memory_model.dart';
import 'package:get_it/get_it.dart';

class AddMemoryProvider with ChangeNotifier {
  final _imageService = GetIt.instance<IImageService>();
  final List<File> _selectedImages = [];
  final TextEditingController messageController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  List<File> get selectedImages => _selectedImages;

  Future<void> pickImages() async {
    try {
      final images = await _imageService.pickImages();
      if (images != null) {
        _selectedImages.addAll(images);
        notifyListeners();
      }
    } catch (e) {
      // Hata yönetimi
    }
  }

  void removeImage(int index) {
    _selectedImages.removeAt(index);
    notifyListeners();
  }

  Future<void> saveMemory() async {
    if (_selectedImages.isNotEmpty && messageController.text.isNotEmpty && dateController.text.isNotEmpty) {
      try {
        final imagePaths = <String>[];
        for (final image in _selectedImages) {
          final imagePath = await _imageService.saveImage(image);
          imagePaths.add(imagePath);
        }

        final memory = MemoryModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          imagePaths: imagePaths,
          message: messageController.text,
          date: DateTime.parse(dateController.text),
        );

        sl<HomeProvider>().addMemory(memory);
      } catch (e) {
        // Hata yönetimi
      } finally {
        RouteManager().pop();
      }
    }
  }
}
