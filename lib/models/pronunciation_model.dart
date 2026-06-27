class PronunciationModel {
  final String? audioUrl;

  PronunciationModel({
    this.audioUrl,
  });

  factory PronunciationModel.fromJson(Map<String, dynamic> json) {
    return PronunciationModel(
      audioUrl: json["audioUrl"] ?? json["audio"] ?? json["url"],
    );
  }
}