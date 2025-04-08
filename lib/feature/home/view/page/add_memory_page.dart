import 'dart:io';
import 'package:diary_mobile/core/constant/app_constants.dart';
import 'package:diary_mobile/core/constant/theme/app_colors.dart';
import 'package:diary_mobile/core/utils/image/i_image_service.dart';
import 'package:diary_mobile/core/utils/screen_size.dart';
import 'package:diary_mobile/feature/home/model/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class AddMemoryPage extends StatefulWidget {
  const AddMemoryPage({super.key});

  @override
  State<AddMemoryPage> createState() => _AddMemoryPageState();
}

class _AddMemoryPageState extends State<AddMemoryPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final _dateController = TextEditingController();
  final List<File> _selectedImages = [];
  final _imageService = GetIt.instance<IImageService>();

  @override
  void dispose() {
    _messageController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final images = await _imageService.pickImages();
      if (images != null) {
        setState(() {
          _selectedImages.addAll(images);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _saveMemory() async {
    if (_formKey.currentState!.validate() && _selectedImages.isNotEmpty) {
      try {
        final imagePaths = <String>[];
        for (final image in _selectedImages) {
          final imagePath = await _imageService.saveImage(image);
          imagePaths.add(imagePath);
        }

        final memory = MemoryModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          imagePaths: imagePaths,
          message: _messageController.text,
          date: DateTime.parse(_dateController.text),
        );
        // TODO: Memory'yi kaydet
        Navigator.pop(context, memory);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anı Ekle')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ScreenSize().getWidth(16)),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  height: ScreenSize().getHeight(200),
                  decoration: BoxDecoration(
                    color: AppColors.foregroundStroke,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _selectedImages.isEmpty
                      ? Icon(Icons.add_photo_alternate, size: 50, color: AppColors.foregroundTertiary)
                      : PageView.builder(
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Image.file(
                                  _selectedImages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: const Icon(Icons.close, color: Colors.white),
                                    onPressed: () => _removeImage(index),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ),
              if (_selectedImages.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${_selectedImages.length} resim seçildi',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.foregroundTertiary),
                  ),
                ),
              SizedBox(height: ScreenSize().getHeight(16)),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Anı Mesajı', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir mesaj girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: ScreenSize().getHeight(16)),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Tarih', border: OutlineInputBorder()),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    _dateController.text = date.toIso8601String().split('T')[0];
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir tarih seçin';
                  }
                  return null;
                },
              ),
              SizedBox(height: ScreenSize().getHeight(24)),
              ElevatedButton(
                onPressed: _saveMemory,
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
