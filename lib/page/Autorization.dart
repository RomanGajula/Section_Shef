import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:localstorage/localstorage.dart';

class LoginMain extends StatefulWidget {
  @override
  Login createState() => Login();
}

class Login extends State<LoginMain> {

  // Future<List<CarBrand>> listCardBrands() async {
  //   final LocalStorage storage = new LocalStorage('todo_app');
  //   CarBrand carBrand;
  //   await storage.ready;
  //   final token = storage.getItem('token');
  //   final responseCarBrands = await http.get(
  //       "https://car-crm.powerit.dev/api/v1/car_brands",
  //       headers: {"Authorization": "Bearer " + token});
  //   var listCarBrands = jsonDecode(responseCarBrands.body);
  //   var listCarBrandsData = listCarBrands["items"]["data"];
  //
  //   List<CarBrand> carBrands = [];
  //
  //   for (var brand in listCarBrandsData) {
  //     carBrand = CarBrand(name: brand["name"]);
  //     carBrands.add(carBrand);
  //   }
  //
  //   return carBrands;
  // }

  // LoginModel loginModel;
  var statusCode;
  String name;
  String password;
  var token;
  bool errorBoxHeight = false;
  int errorBoxPadding = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyEmail = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.8],
                colors: [Colors.blueAccent.withOpacity(0.2), Colors.white])),
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          // final loginProvide = LoginProvide();
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
                  child: Flexible(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 130),
                            width: viewportConstraints.maxWidth,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 140, 0, 210),
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.all(
                                      Radius.circular(1250)),),
                                  // child: Image(
                                  //     image:
                                  //     AssetImage("assets/images/car.png")),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            width: viewportConstraints.maxWidth,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      errorBoxPadding.toDouble(),
                                      errorBoxPadding.toDouble(),
                                      errorBoxPadding.toDouble(),
                                      errorBoxPadding.toDouble()),
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Visibility(
                                    visible: errorBoxHeight,
                                    child: Text(
                                      "Неверный логин или пароль!",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.red),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                                  child: Column(children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.fromLTRB(16, 0, 0, 4),
                                      child: Text(
                                        "Емайл:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(25)),
                                      child: Form(
                                        key: formKeyEmail,
                                        child: TextFormField(
                                          controller: emailController,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Пожалуйста заполните поле";
                                            } else
                                              return null;
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white54,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20, 18, 202, 18),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    224, 224, 224, 1),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        47, 111, 237, 1))),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                            OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    14),
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        47, 111, 237, 1))),
                                            hintText: "Емайл",
                                            hintStyle: TextStyle(
                                                color: Color.fromRGBO(
                                                    189, 189, 189, 1)),
                                          ),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13),
                                          textAlignVertical:
                                          TextAlignVertical.center,
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Container(
                                    child: Column(children: [
                                      Container(
                                          child: Column(children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.fromLTRB(16, 0, 0, 4),
                                              child: Text(
                                                "Пароль:",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              child: Form(
                                                key: formKey,
                                                child: TextFormField(
                                                  controller: passwordController,
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return "Пожалуйста заполните поле";
                                                    } else
                                                      return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white54,
                                                    contentPadding: EdgeInsets.fromLTRB(
                                                        16, 12, 0, 11),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                        color: Color.fromRGBO(
                                                            224, 224, 224, 1),
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(20),
                                                        borderSide: BorderSide(
                                                            color: Color.fromRGBO(
                                                                47, 111, 237, 1))),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(20),
                                                        borderSide: BorderSide(
                                                            color: Colors.red)),
                                                    focusedErrorBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                        borderSide: BorderSide(
                                                            color: Color.fromRGBO(
                                                                47, 111, 237, 1))),
                                                    hintText: "Пароль",
                                                    hintStyle: TextStyle(
                                                        color: Color.fromRGBO(
                                                            189, 189, 189, 1)),
                                                  ),
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                  textAlignVertical:
                                                  TextAlignVertical.center,
                                                ),
                                              ),
                                            ),
                                          ]))
                                    ])),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 130, 0, 24),
                                  width: viewportConstraints.maxWidth,
                                  height: 40,
                                  child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(8.0)),
                                    // onPressed: () async {
                                    //   await loginProvide
                                    //       .createUser(emailController.text, passwordController.text);
                                    //   setState(()  {
                                    //     // loginProvide.email = emailController.text;
                                    //   });
                                    //   setState(() {
                                    //     statusCode = loginProvide.statusCode;
                                    //     if (statusCode != 200 && formKey.currentState.validate() && formKeyEmail.currentState
                                    //         .validate()) {
                                    //       errorBoxHeight = true;
                                    //       errorBoxPadding = 5;
                                    //     } else {
                                    //       errorBoxHeight = false;
                                    //       errorBoxPadding = 0;
                                    //     }
                                    //   });
                                    //   if (formKey.currentState.validate() &&
                                    //       formKeyEmail.currentState
                                    //           .validate() &&
                                    //       statusCode == 200) {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 CarBrands()));
                                    //   }
                                    // },
                                    child: Text(
                                      "Войти",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    color: Color.fromRGBO(47, 111, 237, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: viewportConstraints.maxWidth,
                            child: Column(children: [
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 ForgotPassword()));
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.fromLTRB(0, 0, 0, 4),
                              //     child: Text(
                              //       "Забыли Пароль?",
                              //       style: TextStyle(
                              //           color: Color.fromRGBO(47, 111, 237, 1),
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.normal),
                              //     ),
                              //   ),
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 Registration()));
                              //   },
                              //   child: Container(
                              //     margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              //     child: Text(
                              //       "Регистрация",
                              //       style: TextStyle(
                              //           color: Colors.blueGrey,
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.normal),
                              //     ),
                              //   ),
                              // ),
                            ]),
                          ),
                        ]),
                  )));
        }),
      ),
    );
  }
}
