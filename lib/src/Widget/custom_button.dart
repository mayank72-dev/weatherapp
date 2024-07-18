import 'package:flutter/material.dart';

customButton(VoidCallback onTap,String title,{double?width,double?height,Color?color}){
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(color: color??Colors.grey),
        width: width??75,
        height: height??30,
        child: Center(child: Text(title),)),
  );
}