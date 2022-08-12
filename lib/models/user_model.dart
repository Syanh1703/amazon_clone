import 'dart:convert';


class UserModel{
  final String id;
  final String name;
  final String email;
  final String pass;
  final String address;
  final String type;
  final String token;
  final List<dynamic> cart;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.pass,
    required this.address,
    required this.type,
    required this.token,
    required this.cart});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'pass': pass,
      'type': type,
      'token': token,
      'cart': cart
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      pass: map['pass'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
              (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());
  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith ({
    String? id,
    String? name,
    String? email,
    String? pass,
    String? address,
    String? type,
    String? token,
    List<dynamic>? cart,
}){
  return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      pass: pass ?? this.pass,
      address: address ?? this.address,
      type: type ?? this.type,
      token: token ?? this.token,
      cart: cart ?? this.cart);
}
}