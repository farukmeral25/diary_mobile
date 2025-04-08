import 'dart:io';

abstract class IImageService {
  Future<List<File>?> pickImages();
  Future<String> saveImage(File imageFile);
  Future<void> deleteImage(String imagePath);
}
