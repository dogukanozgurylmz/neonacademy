import 'dart:convert';
import 'package:basketballapp/constants/url_constant.dart';
import 'package:basketballapp/model/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductModel>> products() async {
    try {
      final response = await http.get(Uri.parse("${UrlConstant.url}/products"));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        var list = data.map((e) => ProductModel.fromJson(e)).toList();
        return list;
      }
      return [];
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
