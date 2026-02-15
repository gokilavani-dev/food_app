import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';
import 'package:random_string/random_string.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:food_delivery_app/services/constant.dart';
import 'package:food_delivery_app/services/widget_support.dart';

class DetailPage extends StatefulWidget {
  final String name, image, price, description;
  const DetailPage({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController addressController = new TextEditingController();
  late Razorpay _razorpay;
  String? name, id, email, address, wallet;
  int quantity = 1, totalPrice = 0;

  getthesharedpref() async {
    name = await SharedPreferencesHelper().getUserName();
    id = await SharedPreferencesHelper().getUserId();
    email = await SharedPreferencesHelper().getUserEmail();
    address = await SharedPreferencesHelper().getUserAddress();
    setState(() {});
  }

  getuserwallet() async {
    await getthesharedpref();
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserWalletByEmail(
      email!,
    );
    wallet = "${querySnapshot.docs[0]["Wallet"]}";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // getthesharedpref();
    getuserwallet();
    totalPrice = int.parse(widget.price);
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffef2b39),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(Icons.arrow_back, size: 30.0, color: Colors.white),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Image.asset(
                widget.image,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.contain,
              ),
            ),
            Text(widget.name, style: AppWidget.headlineTextFieldStyle()),
            Text(
              '\u20B9${widget.price}',
              style: AppWidget.priceTextFieldStyle(),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                widget.description,
                style: AppWidget.simpleTextFieldStyle(),
              ),
            ),
            SizedBox(height: 30.0),
            Text("Quantity", style: AppWidget.simpleTextFieldStyle()),
            SizedBox(height: 10.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    quantity += 1;
                    totalPrice = totalPrice + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 30.0),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Text('$quantity', style: AppWidget.headlineTextFieldStyle()),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    if (quantity > 1) {
                      quantity -= 1;
                      totalPrice = totalPrice - int.parse(widget.price);
                      setState(() {});
                    }
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        '\u20B9${totalPrice.toString()}',
                        style: AppWidget.boldWhiteTextFieldStyle(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30.0),
                GestureDetector(
                  onTap: () async {
                    if (address == null) {
                      openBox();
                    } else if (int.parse(wallet!) >= totalPrice) {
                      int updatedWallet = int.parse(wallet!) - totalPrice;
                      await DatabaseMethods().updateUserWallet(
                        updatedWallet.toString(),
                        id!,
                      );
                      String orderId = randomAlphaNumeric(10);
                      // ✅ Order data map here
                      Map<String, dynamic> userOrderMap = {
                        "Name": name,
                        "Id": id,
                        "Quantity": quantity.toString(),
                        "Total": totalPrice.toString(),
                        "Email": email,
                        "FoodName": widget.name,
                        "FoodImage": widget.image,
                        "OrderId": orderId,
                        "Status": "Pending",
                        "Address": address ?? addressController.text,
                        // "PaymentId": response.paymentId,
                      };
                      await DatabaseMethods().addUserOrderDetails(
                        userOrderMap,
                        id!,
                        orderId,
                      );
                      await DatabaseMethods().addAdminOrderDetails(
                        userOrderMap,
                        orderId,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            "Order Placed Sucessfully",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Add some money to your wallet",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "ORDER NOW",
                          style: AppWidget.whiteTextFieldStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void makePayment(String amount) {
    var options = {
      'key': razorpayKey,

      // ✅ amount String → int convert
      'amount': int.parse(amount) * 100, // paisa

      'name': name ?? "Food Delivery App",
      'description': "Food Order Payment",

      'prefill': {'email': email ?? "test@gmail.com"},

      'theme': {'color': "#ef2b39"},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    String orderId = randomAlphaNumeric(10);
    // ✅ Order data map here
    Map<String, dynamic> userOrderMap = {
      "Name": name,
      "Id": id,
      "Quantity": quantity.toString(),
      "Total": totalPrice.toString(),
      "Email": email,
      "FoodName": widget.name,
      "FoodImage": widget.image,
      "OrderId": orderId,
      "Status": "Pending",
      "Address": address ?? addressController.text,
      // "PaymentId": response.paymentId,
    };
    await DatabaseMethods().addUserOrderDetails(userOrderMap, id!, orderId);
    await DatabaseMethods().addAdminOrderDetails(userOrderMap, orderId);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "Order Placed Sucessfully",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
    print(userOrderMap);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Success 🎉"),
        content: Text("Payment Successful"),
      ),
    );
  }

  void handlePaymentError(PaymentFailureResponse response) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Failed ❌"),
        content: Text("Payment Cancelled"),
      ),
    );
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    print("Wallet: ${response.walletName}");
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }

  Future openBox() => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel),
                  ),
                  SizedBox(height: 30.0),
                  Text(
                    "Add the address",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff008080),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text("Add address"),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Address",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  if (addressController.text.isNotEmpty) {
                    // 1️⃣ Save address in SharedPreferences
                    await SharedPreferencesHelper().saveUserAddress(
                      addressController.text,
                    );

                    // 2️⃣ Update address variable
                    setState(() {
                      address = addressController.text;
                    });

                    // 3️⃣ Close dialog
                    Navigator.pop(context);

                    // 4️⃣ Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "Address Added Successfully ✅",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );

                    // 5️⃣ Direct Payment Open
                    Future.delayed(Duration(milliseconds: 500), () {
                      makePayment(totalPrice.toString());
                    });
                  }
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff008080),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
