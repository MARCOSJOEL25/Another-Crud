import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

// ignore: camel_case_types
class provider_crud extends ChangeNotifier {
  List<Product> ListProduct = [];

  provider_crud() {
    getProduct();
  }

  getProduct() async {
    var url = Uri.https('192.168.100.221:7248', 'api/Product');
    var response = await http.get(url);
    ListProduct = productFromJson(response.body);
    for (var element in ListProduct) {
      print(element.productId);
    }
    notifyListeners();
  }

  CreateAndUpdateProduct(String nombre, String apellido) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://192.168.100.221:7248/api/Product'));
    request.body =
        json.encode({"productName": nombre, "description": apellido});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }

    notifyListeners();
  }

  deleteProduct(int id) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'DELETE', Uri.parse('https://192.168.100.221:7248/api/Product/$id'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
  }
}
