import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '/src/sticker_picker_view.dart';
import 'package:path/path.dart' as path;

class LoveStickersCategory extends StickerCategory {
  LoveStickersCategory() : super(
    name: 'Любовь',
    stickers: _loadStickers(),
  );

  static List<Image> _loadStickers() {
    try {
      final currentDir = Directory.current.path;
      final jsonPath = path.join(currentDir, 'encoded_love_stickers.json');
      final file = File(jsonPath);
      
      final jsonString = file.readAsStringSync();
      final Map<String, String> decodedData = jsonDecode(jsonString);
      
      List<Image> images = [];

      for (var sticker in decodedData.entries) {
        final image = Image.memory(base64Decode(sticker.value));
        images.add(image);
      }

      return images;
    } catch (e) {
      return [];
    }
  }
} 