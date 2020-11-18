import 'package:flutter/material.dart';

void main()
{
  runApp(HealthGuard());
}

class HealthGuard extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}