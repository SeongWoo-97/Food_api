import 'package:flutter/material.dart';
import 'package:food_api/screen/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _loading = false;
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Center(
              child: Text(
                'Food API',
                style: TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: _loading ? CircularProgressIndicator() : Container(),
          )
        ],
      ),
    );
  }
}