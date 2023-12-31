import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child: Column(
            children: [Row(
              children: [Expanded(child:  Text('Delivering to BH1'), flex: 5,), 
                Expanded(child: Icon(Icons.person))
              ],
            ),
            ],
          ),
        ),
    );
  }
}
