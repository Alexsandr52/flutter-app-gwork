class Analysis {
  final String? title;
  final String? text;
  final String imgUrl;
  final int patientId;
  final List<Box>? boxes;

  Analysis({
    required this.imgUrl,
    required this.patientId,
    this.text,
    this.title,
    this.boxes,
  });

  factory Analysis.fromJson(Map<String, dynamic> json, int patientId) {
    List<Box>? boxes;
    if (json['boxes'] != null && json['boxes'] is Map<String, dynamic>) {
      var boxesData = json['boxes']['boxes'] as List;
      boxes = boxesData.map((box) => Box.fromJson(box)).toList();
    }
    return Analysis(
      imgUrl: json['image_data'],
      patientId: patientId,
      text: json['result_data'],
      title: json['processing_status'],
      boxes: boxes,
    );
  }
}

class Box {
  final double x;
  final double y;
  final double width;
  final double height;

  Box({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory Box.fromJson(List<dynamic> json) {
    return Box(
      x: json[0].toDouble(),
      y: json[1].toDouble(),
      width: json[2].toDouble(),
      height: json[3].toDouble(),
    );
  }
}
