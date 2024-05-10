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
}
