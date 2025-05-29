class Person {
  Person({
    required this.name,
    required this.year,
    required this.height,
  });

  final String name;
  final int year;
  final double height;

  Person copyWith({
    String? name,
    int? year,
    double? height,
  }) {
    return Person(
      name: name ?? this.name,
      year: year ?? this.year,
      height: height ?? this.height,
    );
  }
}
