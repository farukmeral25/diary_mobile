import 'dart:io';
import 'package:diary_mobile/core/constant/app_page_routes.dart';
import 'package:diary_mobile/core/constant/theme/app_colors.dart';
import 'package:diary_mobile/core/utils/route_manager.dart';
import 'package:diary_mobile/core/utils/screen_size.dart';
import 'package:diary_mobile/feature/home/model/memory_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MemoryModel> _memories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anılarım')),
      body: _memories.isEmpty
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
              itemCount: _memories.length,
              itemBuilder: (context, index) {
                final memory = _memories[index];
                return Card(
                  margin: EdgeInsets.only(bottom: ScreenSize().getHeight(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: ScreenSize().getHeight(200),
                        child: PageView.builder(
                          itemCount: memory.imagePaths.length,
                          itemBuilder: (context, imageIndex) {
                            return Image.file(
                              File(memory.imagePaths[imageIndex]),
                              fit: BoxFit.cover,
                            );
                          },
                        ),
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
        onPressed: () async {
          RouteManager().navigateTo(AppPageRoutes.addMemory);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
