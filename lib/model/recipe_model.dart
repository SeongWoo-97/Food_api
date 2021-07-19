class RecipeModel {
  String label;
  String image;
  String source;
  String shareAs;
  num calories;
  num totalWeight;

  RecipeModel({
    required this.label,
    required this.image,
    required this.source,
    required this.shareAs,
    required this.calories,
    required this.totalWeight,
  });
}
