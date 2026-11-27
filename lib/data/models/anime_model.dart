class AnimeModel {
  final String title;
  final String link;
  final String image;

  AnimeModel({
    required this.title,
    required this.link,
    required this.image,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      title: json['title'] ?? 'Sin título',
      link: json['link'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
