import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';
import 'package:food_delivery_app/services/widget_support.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id;
  getthesharedpref() async {
    id = await SharedPreferencesHelper().getUserId();

    setState(() {});
  }

  getontheload() async {
    await getthesharedpref();
    orderStream = await DatabaseMethods().getUserOrders(id!);
    setState(() {});
  }

  Stream? orderStream;

  Widget allOrders() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(
                      right: 20.0,
                      left: 20.0,
                      bottom: 20.0,
                    ),
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Color(0xffef2b39),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  ds["Address"],
                                  style: AppWidget.simpleTextFieldStyle(),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Image.asset(
                                  ds["FoodImage"],
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 20.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ds["FoodName"],
                                      style: AppWidget.boldTextFieldStyle(),
                                    ),
                                    SizedBox(height: 5.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.format_list_numbered,
                                          color: Color(0xffef2b39),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          ds["Quantity"],
                                          style: AppWidget.boldTextFieldStyle(),
                                        ),
                                        SizedBox(width: 30),
                                        Icon(
                                          Icons.payments_outlined,
                                          color: Color(0xffef2b39),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "\u20B9${ds["Total"]}",
                                          style: AppWidget.boldTextFieldStyle(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      ds["Status"] + "!",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xffef2b39),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
    getontheload();
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
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: allOrders(),
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
}
