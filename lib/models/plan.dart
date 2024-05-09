class Plan {
  final String id;
  final String description; //
  final String imagePath; // lib/image/..
  final String timeFund; //
  final String status; //
  final DateTime dateCreate;
  Plan({
    required this.id,
    required this.description,
    required this.imagePath,
    required this.timeFund,
    required this.status,
    required this.dateCreate,
  });
}
