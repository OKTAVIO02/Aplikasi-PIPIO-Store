import '../utils/formatters.dart';

class Product {
  // Encapsulation: private fields
  String _name;
  String _description;
  String _image;
  double _price;
  double _rating;

  Product({
    required String name,
    required String description,
    required String image,
    required double price,
    double rating = 3.5,
  })  : _name = name,
        _description = description,
        _image = image,
        _price = price,
        _rating = rating;

  // Getter
  String get name => _name;
  String get description => _description;
  String get image => _image;
  double get price => _price;
  double get rating => _rating;

  // Setter
  set name(String value) => _name = value;
  set description(String value) => _description = value;
  set image(String value) => _image = value;
  set price(double value) => _price = value;
  set rating(double value) => _rating = value;

  // Polymorphism: info bisa dioverride
  String get info => '$name: $description - ${formatCurrency(price)}';
}

// Inheritance & Polymorphism
class DiscountProduct extends Product {
  double _discount;

  DiscountProduct({
    required String name,
    required String description,
    required String image,
    required double price,
    required double discount,
  })  : _discount = discount,
        super(
          name: name,
          description: description,
          image: image,
          price: price,
        );

  // Getter & Setter
  double get discount => _discount;
  set discount(double value) => _discount = value;

  double get discountedPrice => price * (1 - discount / 100);

  @override
  String get info =>
    '$name (Diskon ${discount.toStringAsFixed(0)}%): $description - ${formatCurrency(discountedPrice)}';
}