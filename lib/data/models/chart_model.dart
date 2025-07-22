class ChartModel {
  final String date;
  final String dayName;
  final int count;

  ChartModel({
    required this.date,
    required this.dayName,
    required this.count,
  });

  factory ChartModel.fromJson(Map<String, dynamic> json) {
    return ChartModel(
      date: json['date'],
      dayName: json['day_name'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'day_name': dayName,
      'count': count,
    };
  }
}
