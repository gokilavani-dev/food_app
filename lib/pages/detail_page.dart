import 'package:flutter/material.dart';
import 'package:food_delivery_app/services/widget_support.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
                "images/pizza1.png",
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.contain,
              ),
            ),
            Text("Cheese Pizza", style: AppWidget.headlineTextFieldStyle()),
            Text('\u20B9299', style: AppWidget.priceTextFieldStyle()),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                "We've established that most cheeses will melt when baked on atop pizza.But which will not only melt but stretch into those gooey,messy strands that can make pizza eating a dlightfully challenging endeavour?",
                style: AppWidget.simpleTextFieldStyle(),
              ),
            ),
            SizedBox(height: 30.0),
            Text("Quantity", style: AppWidget.simpleTextFieldStyle()),
            SizedBox(height: 10.0),
            Row(
              children: [
                Material(
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
                SizedBox(width: 20.0),
                Text("1", style: AppWidget.headlineTextFieldStyle()),
                SizedBox(width: 20.0),
                Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.remove, color: Colors.white, size: 30.0),
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
                        '\u20B9299',
                        style: AppWidget.boldWhiteTextFieldStyle(),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30.0),
                Material(
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
