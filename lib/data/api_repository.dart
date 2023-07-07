import 'package:card_info_from_api/models/card_model.dart';

import '../models/universal_responce.dart';
import 'api_provider.dart';

class CurrencyRepository {
  final ApiProvider apiProvider;
  CurrencyRepository({required this.apiProvider});

  Future<List<CardModel>>fetchCurrencies()async{
    UniversalResponse universalResponse=await apiProvider.getAllCurrencies();
    if(universalResponse.error.isEmpty){
      return universalResponse.data as List<CardModel>;
    }
    return [];
  }
}