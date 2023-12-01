class BookingData {
  final String status;
  final int count;

  BookingData(this.status, this.count);

  factory BookingData.fromJson(Map<String, dynamic> json) {
    final status = json['status'] as String? ?? 'Unknown';
    final count = json['count'] as int? ?? 0;

    return BookingData(status, count);
  }
}
