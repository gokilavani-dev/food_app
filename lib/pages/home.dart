import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/burger_model.dart';
import 'package:food_delivery_app/model/category_model.dart';
import 'package:food_delivery_app/model/pizza_model.dart';
import 'package:food_delivery_app/pages/detail_page.dart';
import 'package:food_delivery_app/services/burger_data.dart';
import 'package:food_delivery_app/services/category_data.dart';
import 'package:food_delivery_app/services/pizza_data.dart';
import 'package:food_delivery_app/services/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];
  List<PizzaModel> pizza = [];
  List<BurgerModel> burger = [];
  String track = "0";
  @override
  void initState() {
    categories = getCategories();
    pizza = getPizza();
    burger = getBurger();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 15.0, top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/logo.png",
                      height: 50,
                      width: 110,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "Order your favourite food!",
                      style: AppWidget.simpleTextFieldStyle(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "images/boy.jpg",
                      height: 60.0,
                      width: 60.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: Color(0xffececf8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search food item...",
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: 30.0),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(
              height: 70.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return categoryTile(
                    categories[index].image!,
                    categories[index].name!,
                    index.toString(),
                  );
                },
              ),
            ),
            SizedBox(height: 10.0),
            track == "0"
                ? Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 15.0,
                      ),
                      itemCount: pizza.length,
                      itemBuilder: (context, index) {
                        return foodTile(
                          pizza[index].image!,
                          pizza[index].name!,
                          pizza[index].price!,
                          pizza[index].description!,
                        );
                      },
                    ),
                  )
                : track == "1"
                ? Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 15.0,
                      ),
                      itemCount: burger.length,
                      itemBuilder: (context, index) {
                        return foodTile(
                          burger[index].image!,
                          burger[index].name!,
                          burger[index].price!,
                          burger[index].description!,
                        );
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget foodTile(String image, String name, String price, String description) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, top: 10.0),
      margin: EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, height: 150.0, width: 150.0, fit: BoxFit.contain),
          Text(name, style: AppWidget.boldTextFieldStyle()),
          Text('\u20B9$price', style: AppWidget.priceTextFieldStyle()),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        image: image,
                        name: name,
                        price: price,
                        description: description,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryTile(String image, String name, String categoryindex) {
    return GestureDetector(
      onTap: () {
        track = categoryindex.toString();
        setState(() {});
      },
      child: track == categoryindex
          ? Container(
              margin: EdgeInsets.only(right: 20.0, bottom: 10.0),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        image,
                        height: 40.0,
                        width: 40.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10.0),
                      Text(name, style: AppWidget.whiteTextFieldStyle()),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(right: 20.0, bottom: 10.0),
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                color: Color(0xffececf8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Image.asset(
                    image,
                    height: 40.0,
                    width: 40.0,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10.0),
                  Text(name, style: AppWidget.simpleTextFieldStyle()),
                ],
              ),
            ),
    );
  }
}
