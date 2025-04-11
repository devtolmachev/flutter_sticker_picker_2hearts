import 'dart:io';
import 'package:path/path.dart' as path;

class StickerPathsUtil {
  /// Получает список путей ко всем файлам в указанной директории
  static List<String> getStickerPaths(String directoryPath) {
    final directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      throw DirectoryNotFoundException('Директория $directoryPath не найдена');
    }

    final List<String> stickerPaths = [];
    
    // Получаем все файлы из директории
    final List<FileSystemEntity> files = directory.listSync();
    
    // Фильтруем только .png файлы и преобразуем их в относительные пути для ассетов
    for (var file in files) {
      if (file is File && path.extension(file.path) == '.png') {
        // Преобразуем абсолютный путь в относительный путь для ассетов
        final relativePath = path.relative(file.path, from: path.dirname(path.dirname(directoryPath)));
        stickerPaths.add(relativePath);
      }
    }
    
    // Сортируем пути для консистентности
    stickerPaths.sort();
    
    return stickerPaths;
  }
}

class DirectoryNotFoundException implements Exception {
  final String message;
  DirectoryNotFoundException(this.message);
} 