import 'package:demo_provider/domain/entities/person.dart';

class PersonModel implements Person {
  PersonModel({this.name, this.lastName, this.picture, this.personId});
  
  factory PersonModel.fromPerson(Person person) => PersonModel(
    name: person.name,
    lastName: person.lastName,
    picture: person.picture
  );


  @override
  String? lastName;

  @override
  String? name;

  @override
  String? picture;

  @override
  int? personId;

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
    name: json['name']['first'],
    lastName: json['name']['last'],
    picture: json['picture']['medium']
  );

  factory PersonModel.fromSqflite(Map<String, dynamic> data) => PersonModel(
    personId: data['personId'] ?? 0,
    name: data['name'],
    lastName: data['lastName'],
    picture: data['picture']
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'lastName': lastName,
    'picture': picture
  };
}