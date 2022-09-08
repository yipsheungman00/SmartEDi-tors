import 'package:smarteditorstestapp/models/address.dart';
import 'package:smarteditorstestapp/models/company.dart';
import 'package:smarteditorstestapp/models/geo.dart';

class FakeAPIResponseUserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;
  final Company company;

  const FakeAPIResponseUserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.phone,
      required this.website,
      required this.address,
      required this.company});

  factory FakeAPIResponseUserModel.fromJson(Map<String, dynamic> json) {
    return FakeAPIResponseUserModel(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        website: json['website'],
        address: Address(
            street: json['address']['street'],
            suite: json['address']['suite'],
            city: json['address']['city'],
            zipcode: json['address']['zipcode'],
            geo: GEO(
                lat: json['address']['geo']['lat'],
                lng: json['address']['geo']['lng'])),
        company: Company(
            name: json['company']['name'],
            catchPhrase: json['company']['catchPhrase'],
            bs: json["company"]["bs"]));
  }
}
