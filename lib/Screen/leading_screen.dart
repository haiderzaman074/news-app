import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
                ),
                height: 550,
                child: const Image(
                  fit: BoxFit.cover,
                  image: AssetImage('images/taj.jpg',),
                ),
              ),
              const SizedBox(height: 13,),
              const Align(
                alignment:  Alignment.center,
                child: Text('News from around the\n\t\t\t\t\t world for you',style:TextStyle(
                  color: Colors.black,fontWeight: FontWeight.w800,fontSize: 24
                ),),
              ),
              const SizedBox(height: 17,),
              const Align(
                alignment:  Alignment.center,
                child: Text('Best time to read,Take your time to read\n\t\t\t\t\t\t\t\t\t\t\t\t littel more of this world',style:TextStyle(
                    color: Colors.black38,fontWeight: FontWeight.w400,fontSize: 18
                ),),
              ),
              const SizedBox(height: 35),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomeScreen()));
              },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    fixedSize:const Size(350,50)
                  ),
                  child: const Text('Get Started',style: TextStyle(
                    fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600
                  ),))
              ]
                ),
        ),
      )
    );
  }
}
