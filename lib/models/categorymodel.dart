class Category {
  String _name;
  String _description;
  String _assetImage;

  Category({
    required String name,
    required String description,
    required String assetImage,
  })  : _name = name,
        _description = description,
        _assetImage = assetImage;

  // Getter
  String get name => _name;
  String get description => _description;
  String get assetImage => _assetImage;

  // Setter
  set name(String value) => _name = value;
  set description(String value) => _description = value;
  set assetImage(String value) => _assetImage = value;

  String get info => '$name: $description';
}

// Inheritance & Polymorphism
class PremiumCategory extends Category {
  String _badge;

  PremiumCategory({
    required String name,
    required String description,
    required String assetImage,
    required String badge,
  })  : _badge = badge,
        super(
          name: name,
          description: description,
          assetImage: assetImage,
        );

  // Getter & Setter
  String get badge => _badge;
  set badge(String value) => _badge = value;

  @override
  String get info => '$name ($badge): $description';
}