import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/services/burger_data.dart';
import 'package:food_delivery_app/services/pizza_data.dart';

class UploadData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadFoodItems() async {
    var burgerList = getBurger();
    var pizzaList = getPizza();

    // Upload Burger Items
    for (var item in burgerList) {
      await _firestore
          .collection("Food")
          .doc(item.name) // document name = Cheese Burger
          .set(item.toMap());
    }

    // Upload Pizza Items
    for (var item in pizzaList) {
      await _firestore.collection("Food").doc(item.name).set(item.toMap());
    }

    print("✅ Uploaded with proper field names!");
  }
}
