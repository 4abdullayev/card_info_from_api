class CardModel {
  // "id":1,
  // "card_type":"VISA",
  // "card_number":"1234 5678 9101 3456",
  // "bank_name":"Hamkorbank",
  // "money_amount":1200000.0,
  // "card_currency":"SO'M",
  // "expire_date":"2024-08-28 12:18:33.933384",
  // "icon_image":"https://assets.stickpng.com/images/58482363cef1014c0b5e49c1.png",
  // "colors":{
  // "color_a":"#3DD14A",
  // "color_b":"#ECD416"
  // }

  final int id;
  final String cardType;
  final String cardNumber;
  final String bankName;
  final num moneyAmount;
  final String cardCurrency;
  final String expireDate;
  final String iconImage;
  final dynamic colors;

  CardModel({
    required this.id,
    required this.cardType,
    required this.cardNumber,
    required this.bankName,
    required this.moneyAmount,
    required this.cardCurrency,
    required this.expireDate,
    required this.iconImage,
    required this.colors,
  });

  factory CardModel.fromJson(Map<String, dynamic> json){
    return CardModel(
      id: json["id"] as int? ?? 0,
      bankName: json["bank_name"]as String? ?? "",
      cardCurrency: json["card_currency"]as String? ?? "",
      cardNumber: json["card_number"]as String? ?? "",
      cardType: json["card_type"]as String? ?? "",
      expireDate: json["expire_date"]as String? ?? "",
      iconImage: json["icon_image"]as String? ?? "",
      moneyAmount: json["money_amount"]as num? ?? 0,
      colors: json["colors"],
    );
  }

}
