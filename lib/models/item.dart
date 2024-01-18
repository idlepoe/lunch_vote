class Item{
  String name;
  String pictureUrl;
  int like;
  int unlike;

  Item(this.name, this.pictureUrl, this.like, this.unlike);

  @override
  String toString() {
    return 'Item{name: $name, pictureUrl: $pictureUrl, like: $like, unlike: $unlike}';
  }
}