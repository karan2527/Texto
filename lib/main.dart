import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:texto/pages/Home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Texto',
      theme: ThemeData(
       
        colorScheme: const ColorScheme.light(
          primary: Colors.black
        ),
        
        textTheme: GoogleFonts.specialEliteTextTheme(Theme.of(context).textTheme),
      ),
      
      home: const Homepage(),
    );
  }
}

