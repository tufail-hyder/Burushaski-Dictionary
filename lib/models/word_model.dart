class Word {
  final String word;
  final String meaning;
  final String? example;
  final String? wordClass;
  bool isFavorite;

  Word({
    required this.word,
    required this.meaning,
    this.example,
    this.wordClass,
    this.isFavorite = false,
  });

  factory Word.fromJson(dynamic json) {
    // Handle both Map<String, dynamic> and Map<dynamic, dynamic>
    final map = _castToStringDynamic(json);

    return Word(
      word: map['word']?.toString() ?? '',
      meaning: map['meaning']?.toString() ?? '',
      example: map['example']?.toString(),
      wordClass: map['wordClass']?.toString() ?? map['class']?.toString(),
    );
  }

  /// Convert Map<dynamic, dynamic> to Map<String, dynamic>
  static Map<String, dynamic> _castToStringDynamic(dynamic json) {
    if (json is Map<String, dynamic>) {
      return json;
    }

    final map = <String, dynamic>{};
    if (json is Map) {
      json.forEach((key, value) {
        map[key.toString()] = value;
      });
    }
    return map;
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'meaning': meaning,
      'example': example,
      'wordClass': wordClass,
    };
  }

  @override
  String toString() => 'Word(word: $word, meaning: $meaning)';
}
