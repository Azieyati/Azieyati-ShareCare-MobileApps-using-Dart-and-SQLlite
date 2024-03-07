class FoodDonateModel {
  final int? donateID;
  final int? userID;
  final String pickupaddress;
  final String fooditems;
  final String pickupdate;
  final String pickuptime;
  final int? quantity;
  final String category;


  FoodDonateModel({
    this.donateID,
    required this.userID,
    required this.pickupaddress,
    required this.fooditems,
    required this.pickupdate,
    required this.pickuptime,
    required this.quantity,
    required this.category,
  });

  factory FoodDonateModel.fromMap(Map<String, dynamic> json) => FoodDonateModel(
    donateID: json["donateID"] ?? null,
    userID: json["userID"] ?? null,
    pickupaddress: json["pickupaddress"] ?? "",
    fooditems: json["fooditems"] ?? "",
    pickupdate: json["pickupdate"] ?? "",
    pickuptime: json["pickuptime"] ?? "",
    quantity: json["quantity"] ?? null,
    category: json["category"] ?? "",

  );


  Map<String, dynamic> toMap() => {
    "donateID": donateID,
    "userID": userID,
    "pickupaddress": pickupaddress,
    "fooditems": fooditems,
    "pickupdate": pickupdate,
    "pickuptime": pickuptime, 
    "quantity": quantity,
    "category": category,
  };
}

