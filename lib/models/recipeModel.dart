class RecipeModel{

  String label;
  String source;
  String image;
  String url;

  RecipeModel({
    required this.image,
    required this.label,
    required this.source,
    required this.url
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json){

    final label = json['label'];
    final source = json['source'];
    final image = json['image'];
    final url = json['url'];

    return RecipeModel(image: image, label: label, source: source, url: url);

  }

}