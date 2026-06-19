class Pronunciation {
  final String word;
  final String? audioUrl;
  final String? phonetic;

  Pronunciation({
    required this.word,
    this.audioUrl,
    this.phonetic,
  });

  factory Pronunciation.fromJson(dynamic json)
  {
    final map = _castToStringDynamic(json);

    return Pronunciation(
      word: map['word']?.toString() ?? '',
      audioUrl: map['audioUrl']?.toString() ?? map['audio_url']?.toString(),
      phonetic: map['phonetic']?.toString(),
    );
  }

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
      'audioUrl': audioUrl,
      'phonetic': phonetic,
    };
  }
}
