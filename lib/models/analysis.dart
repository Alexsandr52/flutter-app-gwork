class Analysis {
  final String? title;
  final String? text;
  final String imgUrl;
  final int patientId;

  Analysis(
      {required this.imgUrl, required this.patientId, this.text, this.title});
}
