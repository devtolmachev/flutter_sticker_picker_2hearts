import 'package:flutter/material.dart';

class StickerCategory {
  final String name;
  final List<Image> stickers;

  StickerCategory({required this.name, required this.stickers});
}

class StickerPickerView extends StatefulWidget {
  final List<StickerCategory> categories;
  final Function(Image stickerPath) onStickerSelected;
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
                final stickerCategory = widget.categories[categoryIndex];                
                List<Image> images = stickerCategory.stickers;
                
                return GridView.builder(
                  // padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final stickerImage = images[index];
                    return HoverStickerWidget(
                      stickerImage: stickerImage,
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
  final Image stickerImage;
  final double stickerSize;
  final Function(Image stickerImage) onSelectedCallback;

  const HoverStickerWidget({
    super.key,
    required this.stickerImage,
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
          onTap: () => widget.onSelectedCallback(widget.stickerImage),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            width: widget.stickerSize,
            height: widget.stickerSize,
            child: widget.stickerImage,
          ),
        ),
      ),
    );
  }
}
