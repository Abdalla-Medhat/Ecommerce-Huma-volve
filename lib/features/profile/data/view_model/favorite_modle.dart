class FavoriteItem {
  int? id;
  bool? favorite;
  String? title;
  String? subtitle;
  String? imageUrl;
  int? price;

  FavoriteItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    favorite = json['favorite'];
    title = json['title'];
    subtitle = json['subtitle'];
    imageUrl = json['imageUrl'];
    price = json['price'];
  }
}
