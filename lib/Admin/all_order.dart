import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/widget_support.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({super.key});

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  getontheload() async {
    orderStream = await DatabaseMethods().getAllOrders();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
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

                                Expanded(
                                  // ⭐ VERY IMPORTANT
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            style:
                                                AppWidget.boldTextFieldStyle(),
                                          ),

                                          SizedBox(width: 20),

                                          Icon(
                                            Icons.payments_outlined,
                                            color: Color(0xffef2b39),
                                          ),
                                          SizedBox(width: 10),

                                          Text(
                                            "\u20B9${ds["Total"]}",
                                            style:
                                                AppWidget.boldTextFieldStyle(),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 5.0),

                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: Color(0xffef2b39),
                                          ),
                                          SizedBox(width: 10),

                                          Flexible(
                                            child: Text(
                                              ds["Name"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppWidget.simpleTextFieldStyle(),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 5.0),

                                      Row(
                                        children: [
                                          Icon(
                                            Icons.mail,
                                            color: Color(0xffef2b39),
                                          ),
                                          SizedBox(width: 10),

                                          Flexible(
                                            // ⭐ Fix Email Overflow
                                            child: Text(
                                              ds["Email"],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppWidget.simpleTextFieldStyle(),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 5.0),

                                      Text(
                                        "${ds["Status"]}!",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0xffef2b39),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      GestureDetector(
                                        onTap: () async {
                                          await DatabaseMethods()
                                              .updateAdminOrders(ds.id);
                                          await DatabaseMethods()
                                              .updateUserOrders(
                                                ds["Id"],
                                                ds.id,
                                              );
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Delivered",
                                              style:
                                                  AppWidget.whiteTextFieldStyle(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                    ],
                                  ),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 48),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 6),
                  Text("All Orders", style: AppWidget.headlineTextFieldStyle()),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: allOrders(), // ⭐ Direct call
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
