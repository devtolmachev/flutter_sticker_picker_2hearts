import 'package:flutter/material.dart';
import 'package:flutter_sticker_picker/src/stickers_categories/love_stickers.dart';

class StickerCategory {
  final String name;
  final List<String> stickerPaths;

  StickerCategory({required this.name, required this.stickerPaths});
}

class StickerPickerView extends StatefulWidget {
  final List<StickerCategory> categories;
  final Function(String stickerPath) onStickerSelected;
  final Color backgroundColor;
  final double stickerSize;

  const StickerPickerView({
    super.key,
    required this.categories,
    required this.onStickerSelected,
    this.backgroundColor = Colors.white,
    this.stickerSize = 64,
  });

  @override
  _StickerPickerViewState createState() => _StickerPickerViewState();
}

class _StickerPickerViewState extends State<StickerPickerView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.categories.length,
      vsync: this,
    );

    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 350,
      // width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Категории стикеров
          TabBar(
            controller: _tabController,
            // isScrollable: true,
            tabs:
                widget.categories
                    .map((category) => Tab(text: category.name))
                    .toList(),
          ),

          // Сетка стикеров
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                _tabController.animateTo(index);
              },
              itemCount: widget.categories.length,
              itemBuilder: (context, categoryIndex) {
                List<String> paths;
                final stickerCategoryName = widget.categories[categoryIndex].name;

                if (stickerCategoryName == "Любовь") {
                  paths = LoveStickersCategory().stickerPaths;
                } else {
                  throw ErrorDescription("Wrong category name");
                }
                
                return GridView.builder(
                  // padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: paths.length,
                  itemBuilder: (context, index) {
                    final stickerPath = paths[index];
                    return HoverStickerWidget(
                      stickerPath: stickerPath,
                      stickerSize: widget.stickerSize,
                      onSelectedCallback: widget.onStickerSelected,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HoverStickerWidget extends StatefulWidget {
  final String stickerPath;
  final double stickerSize;
  final Function(String stickerPath) onSelectedCallback;

  const HoverStickerWidget({
    super.key,
    required this.stickerPath,
    required this.stickerSize,
    required this.onSelectedCallback,
  });

  @override
  State<StatefulWidget> createState() => _HoverStickerWidget();
}

class _HoverStickerWidget extends State<HoverStickerWidget> {
  late bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      cursor: SystemMouseCursors.click,
      child: Container(
        color:
            _isHovered == false
                ? Colors.transparent
                : const Color.fromARGB(255, 228, 228, 228),
        child: GestureDetector(
          onTap: () => widget.onSelectedCallback(widget.stickerPath),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              widget.stickerPath,
              width: widget.stickerSize,
              height: widget.stickerSize,
            ),
          ),
        ),
      ),
    );
  }
}
