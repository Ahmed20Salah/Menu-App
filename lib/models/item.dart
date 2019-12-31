class Item {
  int id;
  String name;
  String description;
  double price;
  int category;
  String image;
  Item.fromMap(Map data) {
    this.name = data['name'];
    this.description = data['description'];
    this.price = data['price'];
    this.category = data['category'];
    this.image = data['image'];
  }
  Item(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.category,
      this.image});
  Map<String, dynamic> toMap() {
    var data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['image'] = image;
    return data;
  }
}
