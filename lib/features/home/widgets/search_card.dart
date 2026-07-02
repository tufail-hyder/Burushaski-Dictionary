import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../core/constants/colors.dart';
import '../../search/controllers/search_controller.dart';
import '../../wordDetails/screens/word_details_screen.dart';

class SearchCard extends StatefulWidget
{
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
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechAvailable = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (controller.suggestions.isNotEmpty) {
          _showOverlay();
        }
      } else {
        _removeOverlay();
      }
    });

    _suggestionsWorker = ever(controller.suggestions, (_) {
      if (!_focusNode.hasFocus) return;

      if (controller.suggestions.isNotEmpty) {
        _showOverlay();
        _overlayEntry?.markNeedsBuild();
      } else {
        _removeOverlay();
      }
    });
  }

  Future<void> _initSpeech() async {
    try {
      _speechAvailable = await _speech.initialize(
        onStatus: (s) => debugPrint('Speech status: $s'),
        onError: (e) => debugPrint('Speech error: $e'),
      );
    } catch (e) {
      debugPrint('Speech init exception: $e');
      _speechAvailable = false;
    }
    if (mounted) setState(() {});
  }

  Future<void> _toggleMic() async {
    if (!_speechAvailable) {
      Get.snackbar('Voice Search', 'Speech recognition not available on this device.');
      return;
    }

    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
      return;
    }

    setState(() => _isListening = true);

    await _speech.listen(
      onResult: (result) {
        final text = result.recognizedWords;
        _textController.text = text;
        _textController.selection = TextSelection.fromPosition(
          TextPosition(offset: _textController.text.length),
        );
        controller.onSearchChanged(text);

        if (result.finalResult) {
          _speech.stop();
          setState(() => _isListening = false);
        }
      },
      listenMode: stt.ListenMode.confirmation,
      partialResults: true,
    );
  }

  @override
  void dispose() {
    _suggestionsWorker?.dispose();
    _removeOverlay();
    _speech.stop();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
    _speech.stop();
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
          cursorColor: AppColors.primary,
          controller: _textController,
          focusNode: _focusNode,
          onChanged: controller.onSearchChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(Iconsax.search_normal_copy,color: AppColors.primary,),
            suffixIcon: IconButton(
              onPressed: _toggleMic,
              icon: Icon(
                _isListening ? Icons.mic : Icons.mic_none_outlined,
                color: AppColors.primary,
              ),
            ),
            hintText: "Search a word...",
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}