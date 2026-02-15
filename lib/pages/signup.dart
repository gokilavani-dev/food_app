import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/bottom_nav.dart';
import 'package:food_delivery_app/pages/login.dart';
import 'package:food_delivery_app/services/database.dart';
import 'package:food_delivery_app/services/shared_pref.dart';
import 'package:food_delivery_app/services/widget_support.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = "", password = "", name = "";
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController mailController = new TextEditingController();

  registration() async {
    if (password != null &&
        nameController.text != "" &&
        mailController.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": mailController.text,
          "Id": Id,
          "Wallet": "0",
        };
        await SharedPreferencesHelper().saveUserId(Id);
        await SharedPreferencesHelper().saveUserEmail(email);
        await SharedPreferencesHelper().saveUserName(nameController.text);
        await DatabaseMethods().addUserDetails(userInfoMap, Id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registered Sucessfully",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is not weak",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18),
              ),
            ),
          );
        }
      }
    }
  }

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
                  height: MediaQuery.of(context).size.height / 1.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          "SignUp",
                          style: AppWidget.headlineTextFieldStyle(),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text("Name", style: AppWidget.signUpTextFieldStyle()),
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
                            hintText: "Enter Name",
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text("Email", style: AppWidget.signUpTextFieldStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: mailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Email",
                            prefixIcon: Icon(Icons.mail_outline),
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
                          if (nameController.text != "" &&
                              mailController.text != "" &&
                              passwordController.text != "") {
                            setState(() {
                              name = nameController.text;
                              email = mailController.text;
                              password = passwordController.text;
                            });
                            registration();
                          }
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
                                "Signup",
                                style: AppWidget.boldWhiteTextFieldStyle(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: AppWidget.simpleTextFieldStyle(),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: Text(
                              "LogIn",
                              style: AppWidget.boldTextFieldStyle(),
                            ),
                          ),
                        ],
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
}
