class News {
  final String title;
  final String text;
  final String? img_url;
  final bool is_important;

  const News({
    required this.title,
    required this.text,
    this.img_url,
    this.is_important = false,
  });
}
