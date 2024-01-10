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

  Future<void> register(String email, String password, String name, int phone, int primary_location)async {
    print(primary_location);
    int statusCode = await Provider.of<User>(context, listen: false).register(email, name, password, phone, primary_location);
    if(statusCode == 200 || statusCode == 201){
      Navigator.pushReplacementNamed(context, '/verify');
    }
    print(statusCode);
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController primaryLocationController = TextEditingController();

    final List<String> locationOptions = ['BH1', 'BH2', 'GH1', 'MSH', 'Delta', 'ED1'];

    final Map<String, int> locationMapping = {
      'BH1': 1,
      'BH2': 2,
      'GH1': 3,
      'MSH': 4,
      'Delta': 5,
      'ED1': 6,
    };

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
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: DropdownButtonFormField<int>(
                                    value: locationMapping[primaryLocationController.text],
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        primaryLocationController.text = locationMapping.keys.firstWhere(
                                                (key) => locationMapping[key] == newValue,
                                            orElse: () => '');
                                      });
                                    },
                                    items: locationOptions.map((String option) {
                                      return DropdownMenuItem<int>(
                                        value: locationMapping[option],
                                        child: Text(option),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Primary Location",
                                      hintStyle: TextStyle(color: Colors.grey.shade700),
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
                              print(primaryLocationController.text);
                              register(email.text, password.text, name.text, int.parse(phone.text), locationMapping[primaryLocationController.text]??1);
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
