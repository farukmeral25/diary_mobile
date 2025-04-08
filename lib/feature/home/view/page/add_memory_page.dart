import 'package:diary_mobile/core/constant/theme/app_colors.dart';
import 'package:diary_mobile/core/utils/screen_size.dart';
import 'package:diary_mobile/feature/home/provider/add_memory_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMemoryPage extends StatelessWidget {
  const AddMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddMemoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Anı Ekle')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ScreenSize().getWidth(16)),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: provider.pickImages,
                child: Container(
                  height: ScreenSize().getHeight(200),
                  decoration: BoxDecoration(
                    color: AppColors.foregroundStroke,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: provider.selectedImages.isEmpty
                      ? Icon(Icons.add_photo_alternate, size: 50, color: AppColors.foregroundTertiary)
                      : PageView.builder(
                          itemCount: provider.selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Image.file(
                                  provider.selectedImages[index],
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: const Icon(Icons.close, color: Colors.white),
                                    onPressed: () => provider.removeImage(index),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                ),
              ),
              if (provider.selectedImages.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${provider.selectedImages.length} resim seçildi',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.foregroundTertiary),
                  ),
                ),
              SizedBox(height: ScreenSize().getHeight(16)),
              TextFormField(
                controller: provider.messageController,
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
                controller: provider.dateController,
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
                    provider.dateController.text = date.toIso8601String().split('T')[0];
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
                onPressed: () {
                  provider.saveMemory();
                },
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
