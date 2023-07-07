import 'dart:convert';

import 'package:card_info_from_api/models/card_model.dart';
import '../models/universal_responce.dart';

import 'package:http/http.dart' as http;

class ApiProvider {
  Future<UniversalResponse> getAllCurrencies() async {
    Uri uri = Uri.parse("https://banking-api.free.mockoapp.net/user_cards");

    try {
      http.Response response = await http.get(uri);
      return UniversalResponse(
        data: (jsonDecode(response.body) as List?)
            ?.map((e) => CardModel.fromJson(e))
            .toList() ??
            [],
      );
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }
}