import 'package:flutter_sticker_picker/src/sticker_picker_view.dart';
import 'package:flutter_sticker_picker/src/utils/sticker_paths_util.dart';

class LoveStickersCategory extends StickerCategory {
  LoveStickersCategory() : super(
    name: 'Любовь',
    stickerPaths: StickerPathsUtil.getStickerPaths('assets/love_stickers')
  );
}
