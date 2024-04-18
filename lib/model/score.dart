class Score {
  final String title;
  final int score;

  Score({required this.title, required this.score});

  @override
  String toString() {
    return 'Score{name: $title, score: $score}';
  }
}