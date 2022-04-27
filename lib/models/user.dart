class User {
  int id;
  String name, email;
  Address address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
  });

  factory User.fromJSON(Map<String, dynamic> parsedJson) {
    return User(
      id: parsedJson['id'],
      name: parsedJson['name'],
      email: parsedJson['email'],
      address: Address.fromJSON(parsedJson['address']),
    );
  }
}

class Address {
  String street, suite, city, zipcode;

  Address(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipcode});

  factory Address.fromJSON(Map<String, dynamic> parsedJson) {
    return Address(
      street: parsedJson['street'],
      suite: parsedJson['suite'],
      city: parsedJson['city'],
      zipcode: parsedJson['zipcode'],
    );
  }
}
