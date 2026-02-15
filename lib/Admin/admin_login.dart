import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Admin/home_admin.dart';
import 'package:food_delivery_app/services/widget_support.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  String password = "", name = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              padding: EdgeInsets.only(top: 30.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffffefbf),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "images/pan.png",
                    height: 180,
                    fit: BoxFit.fill,
                    width: 250,
                  ),
                  Image.asset(
                    "images/logo.png",
                    width: 150,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3.1,
                left: 20.0,
                right: 20.0,
              ),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.only(right: 20, left: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: MediaQuery.of(context).size.height / 2.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          "Admin",
                          style: AppWidget.headlineTextFieldStyle(),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text("Username", style: AppWidget.signUpTextFieldStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Username",
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),

                      Text("Password", style: AppWidget.signUpTextFieldStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Password",
                            prefixIcon: Icon(Icons.password_outlined),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      GestureDetector(
                        onTap: () {
                          logInAdmin();
                        },
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xffef2b39),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "LogIn",
                                style: AppWidget.boldWhiteTextFieldStyle(),
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
          ],
        ),
      ),
    );
  }

  logInAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != nameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Your username is incorrect",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else if (result.data()['password'] !=
            passwordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Your password is incorrect",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeAdmin()),
          );
        }
      });
    });
  }
}
