import 'dart:io';
import 'package:diary_mobile/core/constant/app_constants.dart';
import 'package:diary_mobile/core/utils/image/i_image_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageService implements IImageService {
  @override
  Future<List<File>?> pickImages() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result == null || result.files.isEmpty) return null;

      final files = <File>[];
      for (final file in result.files) {
        if (file.path == null) continue;

        final fileObj = File(file.path!);
        final extension = path.extension(file.path!).toLowerCase().replaceAll('.', '');

        if (!AppConstants.allowedImageExtensions.contains(extension)) {
          throw Exception('Desteklenmeyen dosya uzantısı. Lütfen jpg, jpeg veya png formatında bir resim seçin.');
        }

        if (await fileObj.length() > AppConstants.maxImageSize) {
          throw Exception('Dosya boyutu çok büyük. Maksimum 5MB olabilir.');
        }

        files.add(fileObj);
      }

      return files;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> saveImage(File imageFile) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageDirectory = Directory('${directory.path}/${AppConstants.imageStoragePath}');

      if (!await imageDirectory.exists()) {
        await imageDirectory.create(recursive: true);
      }

      final fileName = '${DateTime.now().millisecondsSinceEpoch}${path.extension(imageFile.path)}';
      final savedImage = await imageFile.copy('${imageDirectory.path}/$fileName');

      return savedImage.path;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteImage(String imagePath) async {
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
