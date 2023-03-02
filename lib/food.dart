class Food {
  final String title;
  final double price;
  final String imagePath;
  final int rating;
  bool isSelected = false;

  Food(
      {required this.title,
      required this.price,
      required this.imagePath,
      required this.rating});
}
