class Rate {
  final String code;
  final String name;
  final double value;
  final double previous;
  final String date;

  Rate(
      {required this.code,
      required this.name,
      required this.date,
      required this.value,
      required this.previous});
}
