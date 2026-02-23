class BurgerModel {
  String? image;
  String? name;
  String? price;
  String? description;

  Map<String, dynamic> toMap() {
    return {
      "Image": image,
      "Name": name!.toUpperCase(),
      "Price": price,
      "Description": description,
      "SearchKey": name![0].toUpperCase(),
    };
  }
}
