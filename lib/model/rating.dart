class Rating {
  Rating({
    required this.source,
    required this.value,
  });

  final String source;
  final String value;

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    source: json["Source"] ?? '',
    value: json["Value"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Source": source,
    "Value": value,
  };
}
