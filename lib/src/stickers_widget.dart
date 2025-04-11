import 'package:flutter/material.dart';


class StickerPickerConfig {
  final int columns;
  final double stickerSize;
  final Color backgroundColor;

  const StickerPickerConfig({
    this.columns = 4,
    this.stickerSize = 80.0,
    this.backgroundColor = const Color(0xFFF2F2F2),
  });
}


class Sticker {
  final String imagePath;
  final String category;

  Sticker({required this.imagePath, required this.category});
}


class StickerPicker extends StatelessWidget {
  final List<Sticker> stickers;
  final StickerPickerConfig config;
  final Function(Sticker) onStickerSelected;

  const StickerPicker({
    super.key,
    required this.stickers,
    required this.onStickerSelected,
    this.config = const StickerPickerConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: config.backgroundColor,
      height: 250, // Высота пикера, как в emoji_picker_flutter
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: config.columns,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: stickers.length,
        itemBuilder: (context, index) {
          final sticker = stickers[index];
          return GestureDetector(
            onTap: () => onStickerSelected(sticker),
            child: Container(
              width: config.stickerSize,
              height: config.stickerSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(sticker.imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            );
        },
      ),
    );
  }
}


class StickerWidget extends StatelessWidget {
  final String imagePath; // Путь к вашему PNG файлу
  final double size; // Размер стикера

  const StickerWidget({
    super.key,
    required this.imagePath,
    this.size = 50, // Размер по умолчанию
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain, // Сохраняет пропорции изображения
        ),
      ),
    );
  }
}
