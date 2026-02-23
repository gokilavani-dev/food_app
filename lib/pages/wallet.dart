import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/constant.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';
import 'package:food_delivery_app/services/widget_support.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  TextEditingController amountController = new TextEditingController();
  late Razorpay _razorpay;
  String? name, id, email, wallet, selectedAmount;

  getthesharedpref() async {
    name = await SharedPreferencesHelper().getUserName();
    id = await SharedPreferencesHelper().getUserId();
    email = await SharedPreferencesHelper().getUserEmail();

    setState(() {});
  }

  getuserwallet() async {
    email = await SharedPreferencesHelper().getUserEmail();
    id = await SharedPreferencesHelper().getUserId();

    walletStream = await DatabaseMethods().getUserTransactions(id!);

    if (email == null) return;

    var snap = await DatabaseMethods().getUserWalletByEmail(email!);

    if (snap.docs.isNotEmpty) {
      wallet = snap.docs.first["Wallet"].toString();
      setState(() {});
    }
  }

  Stream? walletStream;

  Widget allTransactions() {
    return StreamBuilder(
      stream: walletStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          ds["Date"],
                          style: AppWidget.headlineTextFieldStyle(),
                        ),
                        SizedBox(width: 20.0),
                        Column(
                          children: [
                            Text("Amount added to wallet"),
                            Text(
                              "\u20B9${ds["Amount"]}",
                              style: TextStyle(
                                color: Color(0xffef2b39),
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getuserwallet();
    print(wallet);
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Orders", style: AppWidget.headlineTextFieldStyle()),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/wallet.png",
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 50.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your Wallet",
                                    style: AppWidget.boldTextFieldStyle(),
                                  ),
                                  Text(
                                    "\u20B9$wallet",
                                    style: AppWidget.headlineTextFieldStyle(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectedAmount = "399";
                              makePayment(selectedAmount!);
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "\u20B9399",
                                  style: AppWidget.priceTextFieldStyle(),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              selectedAmount = "299";
                              makePayment(selectedAmount!);
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "\u20B9299",
                                  style: AppWidget.priceTextFieldStyle(),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              selectedAmount = "798";
                              makePayment(selectedAmount!);
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "\u20B9798",
                                  style: AppWidget.priceTextFieldStyle(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () {
                        openBox();
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xffef2b39),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Add Money",
                            style: AppWidget.boldWhiteTextFieldStyle(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "Your Transactins",
                              style: AppWidget.boldTextFieldStyle(),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: MediaQuery.of(context).size.height / 2.84,
                              child: allTransactions(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
    int currentWallet = int.parse(wallet ?? "0");
    int addedMoney = int.parse(selectedAmount!);

    int updatedWallet = currentWallet + addedMoney;

    await DatabaseMethods().updateUserWallet(updatedWallet.toString(), id!);

    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd MMM").format(now);

    Map<String, dynamic> userTransaction = {
      "Amount": selectedAmount,
      "Date": formattedDate,
    };
    await DatabaseMethods().addUserTransactions(userTransaction, id!);

    // ✅ Clear after success
    amountController.clear();
    selectedAmount = null;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text("Money Added Successfully 🎉"),
      ),
    );

    getuserwallet();
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
                    "Add Amount",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff008080),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text("Enter amount"),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Amount",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  if (amountController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter amount ❗")),
                    );
                    return;
                  }

                  if (int.tryParse(amountController.text) == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Enter valid number ❗")),
                    );
                    return;
                  }

                  selectedAmount = amountController.text;

                  Navigator.pop(context); // ✅ CLOSE DIALOG FIRST

                  makePayment(selectedAmount!); // ✅ THEN OPEN PAYMENT
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
