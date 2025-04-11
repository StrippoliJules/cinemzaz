class TVShow {
  final String id;
  final String name;
  final String image;
  final String? description;

  TVShow({
    required this.id,
    required this.name,
    required this.image,
    this.description,
  });

  factory TVShow.fromPopularJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      image: json['image_thumbnail_path'] ?? '',
      description: null,
    );
  }
  
  factory TVShow.fromDetailsJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      image: json['image_path'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
