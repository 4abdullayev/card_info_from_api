import 'package:card_info_from_api/models/card_model.dart';
import 'package:flutter/material.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../data/api_provider.dart';
import '../data/api_repository.dart';
import '../models/universal_responce.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final CurrencyRepository currencyRepository =
      CurrencyRepository(apiProvider: ApiProvider());

  List<CardModel> currencies = [];

  bool isLoading = false;

  getData() async {
    UniversalResponse universalResponse =
        await ApiProvider().getAllCurrencies();
    print(universalResponse.error);
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    currencies = await currencyRepository.fetchCurrencies();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "My Cards",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white,),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            )
          : currencies.isEmpty
              ? const Center(child: Text("Not Found"))
              : ListView(
                  children: [
                    ...List.generate(
                      currencies.length,
                      (index) {
                        CardModel currency = currencies[index];
                        String colorA =
                            "0xFF${currency.colors["color_a"].toString().substring(1)}";
                        String colorB =
                            "0xFF${currency.colors["color_b"].toString().substring(1)}";
                        return ZoomTapAnimation(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  Color(int.parse(colorA)),
                                  Color(int.parse(colorB)),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      currency.bankName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      currency.cardType,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Center(
                                  child: Text(
                                    "${currency.moneyAmount.toString()} ${currency.cardCurrency}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "${currency.cardNumber}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${currency.expireDate}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: Colors.white),
                                    ),
                                    Image.network(currency.iconImage,
                                        width: 50),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
    );
  }
}
