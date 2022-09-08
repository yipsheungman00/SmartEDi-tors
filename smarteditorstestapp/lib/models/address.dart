import 'geo.dart';

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GEO geo;

  const Address(
      {required this.street,
      required this.suite,
      required this.city,
      required this.zipcode,
      required this.geo});
}
