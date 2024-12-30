class ProductModel {
  int productId;
  double? price;
  double? oldPrice;
  double? discount;
  String? image;
  String? description;
  String? name;
  int quantity;
  int cartItemId;

  ProductModel({
    required this.productId,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.description,
    required this.name,
    required this.image,
    required this.quantity,
    required this.cartItemId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    return ProductModel(
      productId: jsonData['id'] ?? 0,
      name: jsonData['name'] ?? 'No Name',
      price: jsonData['price'] != null
          ? (jsonData['price'] is num
              ? (jsonData['price'] as num).toDouble()
              : double.tryParse(jsonData['price'].toString()) ?? 0.0)
          : null,
      oldPrice: jsonData['old_price'] != null
          ? (jsonData['old_price'] is num
              ? (jsonData['old_price'] as num).toDouble()
              : double.tryParse(jsonData['old_price'].toString()) ?? 0.0)
          : null,
      discount: jsonData['discount'] != null
          ? (jsonData['discount'] is num
              ? (jsonData['discount'] as num).toDouble()
              : double.tryParse(jsonData['discount'].toString()) ?? 0.0)
          : null,
      description: jsonData['description'] ?? '',
      image: jsonData['image'] ?? '',
      quantity: jsonData['quantity'] != null
          ? (jsonData['quantity'] is int
              ? jsonData['quantity']
              : int.tryParse(jsonData['quantity'].toString()) ?? 0)
          : 0,
      cartItemId: jsonData['cartItemId'] ?? 0, // Reading cartItemId correctly
    );
  }
}
