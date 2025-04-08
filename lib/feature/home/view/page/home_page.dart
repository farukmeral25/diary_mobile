import 'dart:io';
import 'package:diary_mobile/core/constant/app_page_routes.dart';
import 'package:diary_mobile/core/utils/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:diary_mobile/core/constant/theme/app_colors.dart';
import 'package:diary_mobile/core/utils/screen_size.dart';
import 'package:diary_mobile/feature/home/provider/home_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Anılarım')),
      body: provider.memories.isEmpty
          ? Center(
              child: Text(
                'Henüz anı eklenmemiş',
                style: TextStyle(
                  color: AppColors.foregroundTertiary,
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(ScreenSize().getWidth(16)),
              itemCount: provider.memories.length,
              itemBuilder: (context, index) {
                final memory = provider.memories[index];
                return Card(
                  margin: EdgeInsets.only(bottom: ScreenSize().getHeight(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: ScreenSize().getHeight(200),
                            child: PageView.builder(
                              itemCount: memory.imagePaths.length,
                              itemBuilder: (context, imageIndex) {
                                final file = File(memory.imagePaths[imageIndex]);
                                if (!file.existsSync()) {
                                  return const Center(child: Text('Resim bulunamadı'));
                                }
                                return Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Opacity(
                              opacity: 0.7,
                              child: IconButton(
                                icon: Icon(Icons.delete, color: AppColors.white),
                                onPressed: () {
                                  provider.removeMemory(index);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(ScreenSize().getWidth(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd.MM.yyyy').format(memory.date),
                              style: TextStyle(
                                color: AppColors.foregroundTertiary,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: ScreenSize().getHeight(8)),
                            Text(
                              memory.message,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RouteManager().navigateTo(AppPageRoutes.addMemory);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
