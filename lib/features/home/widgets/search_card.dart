import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../search/controllers/search_controller.dart';
import '../../wordDetails/screens/word_details_screen.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({super.key});

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  final DictionarySearchController controller = Get.find<DictionarySearchController>();

  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;
  Worker? _suggestionsWorker;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });

    // Listen to GetX suggestions changes and refresh overlay
    _suggestionsWorker = ever<List<dynamic>>(controller.suggestions, (_) {
      if (_focusNode.hasFocus) {
        _overlayEntry?.markNeedsBuild();
        if (controller.suggestions.isNotEmpty) {
          _showOverlay();
        } else {
          _removeOverlay();
        }
      }
    });
  }

  @override
  void dispose() {
    _suggestionsWorker?.dispose();
    _removeOverlay();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final renderBox = _fieldKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox == null) return const SizedBox.shrink();

        final size = renderBox.size;

        return Stack(
          children: [
            // Tap outside to close
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _focusNode.unfocus();
                  _removeOverlay();
                },
              ),
            ),

            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, size.height + 8),
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 240,
                    minWidth: size.width,
                    maxWidth: size.width,
                  ),
                  child: Obx(() {
                    final items = controller.suggestions;
                    if (items.isEmpty) return const SizedBox.shrink();

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: items.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      itemBuilder: (_, index) {
                        final item = items[index];
                        return ListTile(
                          dense: true,
                          leading: const Icon(Icons.search),
                          title: Text(
                            item.word,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            item.meaning,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap: () {
                            _textController.text = item.word;
                            controller.suggestions.clear();
                            _focusNode.unfocus();
                            _removeOverlay();

                            Get.to(() => WordDetailScreen(vocabulary: item));
                          },
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context, rootOverlay: true).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _fieldKey,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: TextField(
          controller: _textController,
          focusNode: _focusNode,
          onChanged: controller.onSearchChanged,
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Iconsax.search_normal_copy),
            suffixIcon: Icon(Icons.mic_none_outlined),
            hintText: "Search a word...",
            contentPadding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}