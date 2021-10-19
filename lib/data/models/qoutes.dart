class Qoute {
  late String quote;
  Qoute.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
  }
}
