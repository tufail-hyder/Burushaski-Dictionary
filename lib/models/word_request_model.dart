class WordRequestModel {
  final String word;
  final String message;

  WordRequestModel({
    required this.word,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      "word": word,
      "message": message,
    };
  }
}