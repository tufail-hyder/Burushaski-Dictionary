class VocabularyModel {
  final int id;
  final String word;
  final String meaning;

  VocabularyModel({
    required this.id,
    required this.word,
    required this.meaning,
  });

  factory VocabularyModel.fromJson(Map<String, dynamic> json) {
    return VocabularyModel(
      id: json["id"] ?? 0,
      word: json["word"] ?? "",
      meaning: json["meaning"] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "word": word,
      "meaning": meaning,
    };
  }
}