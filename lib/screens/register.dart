import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Future<void> register(String email, String password, String name, int phone)async {
    int statusCode = await Provider.of<User>(context, listen: false).register(email, name, password, phone);
    if(statusCode == 200){
      Navigator.pushReplacementNamed(context, '/verify');
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Consumer<User>(
            builder: (context, userProvider, _){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 400,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: -40,
                          height: 400,
                          width: width,
                          child: FadeInUp(
                            duration: const Duration(seconds: 1),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/background.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 400,
                          width: width + 20,
                          child: FadeInUp(
                            duration: const Duration(milliseconds: 1000),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  AssetImage('assets/images/background-2.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 1500),
                          child: Text(
                            "Register",
                            style: TextStyle(
                              color: Color.fromRGBO(49, 39, 79, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1700),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: Color.fromRGBO(196, 135, 198, .3),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromRGBO(196, 135, 198, .3),
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: email,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                    ),
                                  ),
                                ),
                                Container(

                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: name,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Name",
                                      hintStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color.fromRGBO(196, 135, 198, .3),
                                      ),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: phone,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Phone",
                                      hintStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextField(
                                    controller: password,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                      TextStyle(color: Colors.grey.shade700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1700),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                              child: Text(
                                "Login?",
                                style: TextStyle(
                                  color: Color.fromRGBO(196, 135, 198, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1900),
                          child: MaterialButton(
                            onPressed: () {
                              register(email.text, password.text, name.text, int.parse(phone.text));
                            },
                            color: Color.fromRGBO(49, 39, 79, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            height: 50,
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 2000),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                // TODO: Implement create account logic
                                Navigator.pushReplacementNamed(context, '/dashboard');
                              },
                              child: Text(
                                "Create Account",
                                style: TextStyle(
                                  color: Color.fromRGBO(49, 39, 79, .6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}