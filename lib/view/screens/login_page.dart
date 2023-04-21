import 'package:flutter/material.dart';
import 'package:test_honours/controller/auth/auth_controller.dart';
import '../screens/signin_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (_, constraints) => SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * .2,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("img/app_login_page_logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello",
                              style: TextStyle(
                                  fontSize: 70, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Sign into your account",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 7,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2))
                                  ]),
                              child: TextField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.blueAccent,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 1.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 1.0)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        spreadRadius: 7,
                                        offset: const Offset(1, 1),
                                        color: Colors.grey.withOpacity(0.2))
                                  ]),
                              child: TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: "Password",
                                    prefixIcon: const Icon(
                                      Icons.password_outlined,
                                      color: Colors.blueAccent,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 1.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 1.0)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                Text(
                                  "Forgot your password?",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[70]),
                                ),
                              ],
                            )
                          ])),
                  const SizedBox(
                    height: 55,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      AuthController.instance.login(emailController.text.trim(),
                          passwordController.text.trim());
                    },
                    // The custom button
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text('Sign In'),
                    ),
                  ),
                  GestureDetector(
                    // When the child is tapped, show a snackbar.
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new SignUpPage())); //your login class name
                    },
                    // The custom button

                    child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: const Text(
                          'Don`t have an account? Create!',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )),
    );
  }



}
