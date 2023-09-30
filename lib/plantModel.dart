import 'package:cloud_firestore/cloud_firestore.dart';

class Plant {
  String? id;
  final String name;
  final String category;
  final String? light;
  final String? water;
  final String? image;
  final String? price;
  final String? description;

  Plant({
    this.id = '',
    required this.name,
    required this.category,
    required this.image,
    required this.light,
    required this.price,
    required this.water,
    required this.description,
  });
  Map<String,dynamic>toJson()=> {
    'id': id,
    'name':name,
    'category':category,
    'image':image,
    'light':light,
    'price':price,
    'water':water,
    'description':description,
  };
  static Plant fromJson(Map<String?,dynamic> json)=>Plant(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      image: json['image'],
      light: json['light'],
      price: json['price'],
      water: json['water'],
      description: json['description']);


  Plant.fromSnapshot(DocumentSnapshot snapshot) :
        id = snapshot['id'],
        name = snapshot['name'],
        category = snapshot['category'],
        image = snapshot['image'],
        light = snapshot['light'],
        price = snapshot['price'],
        water = snapshot['water'],
        description = snapshot['description'];

}