import 'package:flutter/material.dart';

void pushReplacment(BuildContext context , Widget nextscreen){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>nextscreen),);
    
}



void pushto(BuildContext context , Widget nextscreen){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>nextscreen),);
    
}