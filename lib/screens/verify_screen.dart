import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  Future<void> verify(String otp) async{
    int statusCode = await Provider.of<User>(context, listen: false).verifyOtp(otp);
    if(statusCode == 201){
      Navigator.pushNamed(context, '/dashboard');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          OtpTextField(
            numberOfFields: 4,
            onSubmit: (pin) {
              print("Completed: " + pin);
            },
          )
        ],
      ),
    );
  }
}
