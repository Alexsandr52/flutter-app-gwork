class News {
  final String title;
  final String text;
  final String? imgUrl;
  final bool isImportant;

  const News({
    required this.title,
    required this.text,
    this.imgUrl,
    this.isImportant = false,
  });

  // Метод для создания объекта News из JSON
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'],
      text: json['news_text'],
      imgUrl: json['news_img'],
      isImportant: false, // Это поле можно настроить по своему усмотрению
    );
  }
}
